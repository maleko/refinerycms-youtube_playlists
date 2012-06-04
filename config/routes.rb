Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :youtube_playlists do
    root :to => "youtube_playlists#index"
    resources :youtube_playlists, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :youtube_playlists, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :youtube_playlists, :except => :show do
        collection do
          post :update_positions
        end

        member do
          get :activate
          get :deactivate
        end
      end

      resource :setting do
        member do
          get :retrieve_playlist
        end
      end
    end
  end

end
