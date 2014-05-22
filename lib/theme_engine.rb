class ThemeEngine < Rails::Engine
  # Add a load path for this specific Engine
  config.autoload_paths << File.expand_path("../themes", __FILE__)
end