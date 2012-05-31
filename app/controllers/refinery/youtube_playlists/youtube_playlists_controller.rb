module Refinery
  module YoutubePlaylists
    class YoutubePlaylistsController < ::ApplicationController

      before_filter :find_all_youtube_playlists
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @youtube_playlist in the line below:
        present(@page)
      end

      def show
        @youtube_playlist = YoutubePlaylist.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @youtube_playlist in the line below:
        present(@page)
      end

    protected

      def find_all_youtube_playlists
        @youtube_playlists = YoutubePlaylist.order('position ASC').active
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/youtube_playlists").first
      end

    end
  end
end
