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
    resources:users, only: [:show, :edit, :update, :destroy] do
      member do
        get "follows"
        get "followers"
      end
      collection do
        get "my_page" => "users#my_page"
        get 'confilm'
        patch 'withdraw'
      end
      resource :relations, only:[:create, :destroy]
      resource :reports, only:[:new, :create]
    end

    resources:posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resource :wants, only: [:create, :destroy]
    end
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
    get 'search' => 'posts#search'
  end

    get '/admin' => 'admin/homes#top'
  namespace :admin do
    resources:users, only: [:index, :show, :edit, :update]
    resources:reports, only: [:index, :show, :update]
    get 'search' => 'posts#search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
