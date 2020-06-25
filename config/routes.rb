HelpCenter::Engine.routes.draw do
  scope module: :help_center do
    resources :support_threads, path: :threads do
      collection do
        get :answered
        get :unanswered
        get :mine
        get :participating
        get "category/:id", to: "support_categories#index", as: :support_category
      end

      resources :support_posts, path: :posts do
        member do
          put :solved
          put :unsolved
        end
      end

      resource :notifications
    end
  end

  root to: "help_center/support_threads#index"
end
