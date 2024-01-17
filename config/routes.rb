Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :items, only: [:index, :show]
    get 'customers/my_page' => 'customers#show'
    get 'costomers/infomation/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all' => 'cart_items#destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm' => 'orders#confirm'
        get 'thanks' => 'orders#thanks'
      end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
