Rails.application.routes.draw do

  # 顧客用

  scope module: :public do
    # customers
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    get "customers/my_page" => "customers#show"
    resource :customers, only: [:edit, :update]

    # homes
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    # items
    resources :items, only: [:index, :show]

    # cart_items
    delete "cart_items/all_destroy" => "cart_items#all_destroy"
    resources :cart_items, only: [:index, :update, :create, :destroy]

    # orders
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/finish' => 'orders#finish'
    resources :orders, only: [:index, :show, :new, :create]

    # addresses
    resources :addresses, only: [:index, :create, :destroy, :update, :edit]

  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }



  # 管理者用

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # homes
    get '/' => 'homes#top'

    # cunstomers
    resources :customers, only: [:index, :show, :edit, :update]

    # items
    resources :items, except: [:destroy]

    # genres
    resources :genres, only: [:index, :create, :edit, :update]

    # orders
    resources :orders, only: [:show, :update]

    # order_details
    resources :order_details, only: [:update]

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
