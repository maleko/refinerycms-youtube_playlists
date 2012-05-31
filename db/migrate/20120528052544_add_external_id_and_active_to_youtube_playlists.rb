class AddExternalIdAndActiveToYoutubePlaylists < ActiveRecord::Migration
  def change
    add_column :refinery_youtube_playlists, :external_id, :string
    add_column :refinery_youtube_playlists, :active,      :boolean
    add_index  :refinery_youtube_playlists, :external_id
  end
end
