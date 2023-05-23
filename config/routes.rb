Rails.application.routes.draw do
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  root to: 'public/homes#top'

  get '/about' => 'public/homes#about'

  scope module: :public do
    resources:users, only: [:edit, :update, :destroy] do
      get ":user_id/follows" => "users#follows", as: "follows"
      get ":user_id/followers" => "users#followers", as: "followers"
      post "profile/:user_id/relation" => "relations#create", as: "relations_post"
      delete "profile/:user_id/relation" => "relations#destroy", as: "relation_delete"
      get "my_page" => "users#show"
      get "profile/:user_id" => "users#profile", as: "profile"

      post "profile/:user_id/report" => "reports#create", as: "profile_report"
      get "profile/:user_id/report/new" => "reports#new", as: "profile_reports_new"
      get 'users/confilm' => 'userss#confilm'
      patch 'users/withdraw' => 'users#withdraw'
    end

    resources:posts, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resource :wants, only: [:create, :destroy]
    end
    get 'search' => 'posts#search'
  end

    get '/admin' => 'admin/homes#top'
  namespace :admin do
    resources:users, only: [:index, :show, :edit, :update]
    resources:orders, only: [:show, :update]
    resources:reports, only: [:index, :show, :update]
    get 'search' => 'posts#search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
