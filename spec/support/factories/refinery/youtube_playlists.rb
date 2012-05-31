
FactoryGirl.define do
  factory :youtube_playlist, :class => Refinery::YoutubePlaylists::YoutubePlaylist do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

