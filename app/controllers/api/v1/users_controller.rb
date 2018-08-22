class Api::V1::UsersController < Api::V1::ApiController
  version 1

  def show
    return error! :forbidden, :metadata => {:error => 'login required'} if current_user.blank?
    current_user.update_attribute :last_access_at, Time.now
    expose current_user, serializer: UserSerializer
  end

  # PUT api/v1/users/me/profile
  def update_profile
    update_password if profile_params[:current_password].present?
    original_extention = File.extname(profile_params[:image].original_filename).downcase rescue profile_params[:image] = nil
    if profile_params[:image].present?
      profile_params[:image].original_filename = SecureRandom.hex(16) + original_extention
      current_user.profile.update!( name: profile_params[:name], image: profile_params[:image])
    else
      current_user.profile.update!( name: profile_params[:name])
    end
    expose current_user, serializer: UserSerializer
  end

  def update_password
    if current_user.valid_password? profile_params[:current_password]
      current_user.update_attributes! password: profile_params[:password], password_confirmation: profile_params[:password_confirmation]
    else
      error! :forbidden, :metadata => {:error => 'incorrect_password'}
    end
  end

  private
  def profile_params
    params.permit(:name, :image, :password, :password_confirmation, :current_password)
  end
end
