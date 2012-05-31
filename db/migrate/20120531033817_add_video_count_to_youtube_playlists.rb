class AddVideoCountToYoutubePlaylists < ActiveRecord::Migration
  def change
    add_column :refinery_youtube_playlists, :video_count, :integer
  end
end
