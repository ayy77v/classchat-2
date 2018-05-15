Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :account do
   resources :groups
   resources :posts
 end



  root 'groups#index' #這行代表把 localhost:3000/groups 這個網址設成首頁
  resources :groups do

  	   member do
     post :join
     post :quit
   end

   resources :posts
 end
end
