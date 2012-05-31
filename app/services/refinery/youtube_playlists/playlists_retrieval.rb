require 'simple_youtube'

module Refinery
  module YoutubePlaylists
    class PlaylistsRetrieval
      PLAYLISTS_URL = "https://gdata.youtube.com/feeds/api/users/%{user_id}/playlists?v=2"
      PLAYLIST_URL  = "https://gdata.youtube.com/feeds/api/playlists/%{playlist_id}?v=2"
      YOUTUBE_THUMBNAIL_SIZE = "mqdefault"

      include ActiveModel::Validations
      include ActiveModel::Serialization
      include ActionView::Helpers::TextHelper
      extend  ActiveModel::Naming

      attr_accessor :user_id, :youtube_playlists

      validates_presence_of :user_id

      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
        @user_id = Refinery::Setting.get(:youtube_userid, :scoping => :youtube_playlists) if @user_id.blank?
      end

      def to_key
        return [:user_id, :youtube_playlists]
      end

      def persisted?
        false
      end

      def retrieve_playlist_id(rss_item)
        tags = rss_item.id.split(':')
        id = tags[tags.index('playlist') + 1]
      end

      def retrieve_playlists
        if self.valid?
          youtube_query = Youtube::User.find(:scope => @user_id, :type => 'playlists', :params => {:v => '2'})
          @youtube_playlists = youtube_query.entry
        end
        self
      end

      def import_playlists
        @youtube_playlists.each do |youtube_playlist|
          refinery_playlist = Refinery::YoutubePlaylists::YoutubePlaylist.where(:playlist_code => youtube_playlist.playlistId, :title => youtube_playlist.title).first_or_create!
          refinery_playlist.deactivate! unless refinery_playlist.active?
          refinery_playlist.update_attributes(:description => youtube_playlist.summary)
        end
        self
      end

      def populate_playlist_details
        refinery_playlists.each do |refinery_playlist|
          youtube_playlist = Youtube::Playlist.find(:scope => refinery_playlist.playlist_code)
          youtube_playlist.group.thumbnail.each do |thumbnail|
            refinery_playlist.thumbnail_url = thumbnail.url if thumbnail.attributes["yt:name"] == YOUTUBE_THUMBNAIL_SIZE
          end
          refinery_playlist.video_count = youtube_playlist.entry.count
          refinery_playlist.save
        end
        self
      end

      def refinery_playlists
        Refinery::YoutubePlaylists::YoutubePlaylist.all
      end

    end
  end
end
