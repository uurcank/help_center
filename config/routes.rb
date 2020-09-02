HelpCenter::Engine.routes.draw do
  scope module: :help_center do
    resources :support_categories, path: :categories
    resources :support_threads, path: :articles do
      collection do
        get :answered
        get :unanswered
        get :mine
        get :participating
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
