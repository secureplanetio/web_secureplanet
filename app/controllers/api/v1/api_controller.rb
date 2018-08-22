module Api
  module V1
    class ApiController < RocketPants::Base
      version 1

      include Doorkeeper::Rails::Helpers
      include Devise::Controllers::Helpers
      include ActionView::Helpers::NumberHelper
      include Pundit

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      private

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      def expose_invalid_resource_error(messages)
        head 422
        expose(
          error: I18n.t('api.errors.unprocessable_entity'),
          messages: messages,
        )
      end

      def error_with_ui_code(key, message = '')
        error_info = MessageCodes::RestCode.get(key)
        head error_info[:head]
        expose(
            error: error_info[:error],
            error_description: message.blank? ? error_info[:error_description] : message,
        )
      end


      def user_not_authorized(exception)
        policy_name = exception.policy.class.to_s.underscore
        description = I18n.t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default,)
        error = change_forbidden_error_code error, description
        head 403
        render_json(
          error: error,
          error_description: description,
        )
      end

      private

      def change_forbidden_error_code error, description
        error = '403-001' if description == I18n.t('pundit.license_policy.registered?')
        error = '403-002' if description == I18n.t('pundit.license_policy.current?')
        error
      end

    end
  end
end
