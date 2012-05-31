class AddThumbnailToRefineryYoutubePlaylists < ActiveRecord::Migration
  def change
    add_column :refinery_youtube_playlists, :thumbnail_url, :string
  end
end
