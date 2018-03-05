Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "todos#index"
  resources :todos do
    member do
      post :toggle_check
    end

    # 增加一個 load action 來處理載入事件。
    # 希望路由的長相是「todos/load」，
    # 因為是所有的 todo 共用的路由，可以用 collection 來處理
    collection do
      get :load
    end
  end
end
