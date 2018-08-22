module Api
  module V1
    class ImagesController < ApplicationController
      before_action :doorkeeper_authorize!, except: [:profile_image]
      before_action :set_user, only: [:profile_image]

      # GET 1/users/me/profile_image/:id
      def profile_image
        return render nothing: true, status: :no_content if @user.blank?
        image_path = @user.profile.image_file_name.blank? ? nil : File.join(@user.profile.image_file_dir, @user.profile.image_file_name)
        if image_path.present? && File.exist?(image_path)
          File.open(image_path, 'rb') do |f|
            send_data f.read, type: @user.profile.image_content_type, disposition: "inline"
          end
        else
          image_path = File.join(Rails.root, 'lib', 'assets', 'image', 'user_default.png')
          File.open(image_path, 'rb') do |f|
            send_data f.read, type: 'image/png', disposition: "inline"
          end
        end
      end

      private
      def set_user
        users = User.where(id: params[:id])
        @user = users.blank? ? nil : users.last
      end
    end
  end
end
