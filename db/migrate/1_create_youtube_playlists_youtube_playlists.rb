class CreateYoutubePlaylistsYoutubePlaylists < ActiveRecord::Migration

  def up
    create_table :refinery_youtube_playlists do |t|
      t.string  :title
      t.string  :playlist_code
      t.text    :description
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-youtube_playlists"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/youtube_playlists/youtube_playlists"})
    end

    drop_table :refinery_youtube_playlists

  end

end
