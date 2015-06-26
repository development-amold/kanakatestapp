Rails.application.routes.draw do
    
    root 'homes#index'

    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 

    get "*unknown_path" => "application#redirect_user", :constraints => { :url => /.*/ }
end
