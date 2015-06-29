Rails.application.routes.draw do
    
    root 'homes#index'

    devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
    get '/auth/facebook/logout' => 'application#facebook_logout', :as => :facebook_logout 
    match 'auth/failure', to: redirect('/'), via: [:get,:post]
    get "/parsehtmlfile" => "homes#parsehtmlfile"
    get "/viewfile" => "homes#viewhtmlfile"
    get "*unknown_path" => "application#redirect_user", :constraints => { :url => /.*/ }
end
