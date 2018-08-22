Rails.application.routes.draw do
  devise_for :users

  api versions: 1, module: "api/v1" do

    resources :users do
      collection do
        get 'me', to: 'users#show'
        get 'me/profile_image/:id' => 'images#profile_image'
        put 'me/profile' => 'users#update_profile'
        post 'oauth/token', to: 'custom_doorkeepers#create'
      end
    end

    resources :clarities do
      collection do
        get 'cve_info/:cve_code', to: 'planets#cve_code_info'
        post 'cve_chart', to: 'planets#cve_chart'
        post 'cve_list', to: 'planets#cve_list'
      end
    end
  end
end
