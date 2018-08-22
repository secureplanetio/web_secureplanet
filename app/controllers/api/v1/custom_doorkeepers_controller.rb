module Api
  module V1
    class CustomDoorkeepersController < Doorkeeper::ApplicationMetalController
      def create
        set_doorkeeper_params
        response = authorize_response
        headers.merge! response.headers
        custom_response_body response.body
        self.response_body = response_body.to_json
        self.status        = response.status
      rescue Exception => e
        handle_token_exception e
      end


      private
      attr_reader :response_body

      def set_doorkeeper_params
        params[:email] = Settings.user.first_user if params[:email] == 'admin'
      end

      def strategy
        @strategy ||= server.token_request params[:grant_type]
      end

      def authorize_response
        @authorize_response ||= strategy.authorize
      end

      def custom_response_body body
        @response_body = body
        @response_body['required_setting'] = []
      end
    end
  end
end
