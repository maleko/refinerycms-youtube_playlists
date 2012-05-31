module Refinery
  module YoutubePlaylists
    class YoutubePlaylist < Refinery::Core::BaseModel
      self.table_name = 'refinery_youtube_playlists'

      acts_as_indexed :fields => [:title, :playlist_code, :description]

      attr_accessible :active, :thumbnail_url, :description

      validates :title, :presence => true, :uniqueness => true
      validates :playlist_code, :presence => true, :uniqueness => true

      scope :active,   where(:active => true)
      scope :inactive, where('active != true')

      def activate!
        self.update_attributes(:active => true)
      end

      def deactivate!
        self.update_attributes(:active => false)
      end
    end
  end
end
