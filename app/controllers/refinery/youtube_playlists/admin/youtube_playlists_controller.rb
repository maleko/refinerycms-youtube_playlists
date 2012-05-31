module Refinery
  module YoutubePlaylists
    module Admin
      class YoutubePlaylistsController < ::Refinery::AdminController

        crudify :'refinery/youtube_playlists/youtube_playlist', :xhr_paging => true

        def activate
          playlist.activate!
          respond_to do |format|
            format.html { redirect_back_or_default(refinery.youtube_playlists_admin_youtube_playlists_path) }
            format.json
          end
        end

        def deactivate
          playlist.deactivate!
          respond_to do |format|
            format.html { redirect_back_or_default(refinery.youtube_playlists_admin_youtube_playlists_path) }
            format.json
          end
        end

        def playlist
          @youtube_playlist ||= Refinery::YoutubePlaylists::YoutubePlaylist.find(params[:id])
        end
      end
    end
  end
end
