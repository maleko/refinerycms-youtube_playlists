# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-youtube_playlists'
  s.author            = 'Marc Lee'
  s.version           = '0.9b'
  s.description       = 'Ruby on Rails Youtube Playlists extension for Refinery CMS'
  s.date              = '2012-05-24'
  s.summary           = 'Youtube Playlists extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.3'
  s.add_dependency             'simple-rss'
  s.add_dependency             'simple_youtube'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.3'
end
