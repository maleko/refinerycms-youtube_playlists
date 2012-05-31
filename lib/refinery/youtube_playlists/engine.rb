module Refinery
  module YoutubePlaylists
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::YoutubePlaylists

      engine_name :refinery_youtube_playlists

      initializer "register refinerycms_youtube_playlists plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "youtube_playlists"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.youtube_playlists_admin_youtube_playlists_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/youtube_playlists/youtube_playlist'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::YoutubePlaylists)
      end
    end
  end
end
