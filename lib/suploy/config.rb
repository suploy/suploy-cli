module Suploy
  module Config
    def url
      config['url']
    end

    def url=(new_url)
      config['url'] = new_url
      write
    end

    def load
      if File.file? config_file_name
        @config = YAML.load_file config_file_name
      end
      ensure_complete_config
    end
    
    def write
      File.open(config_file_name, 'w') do |f|
        YAML.dump(config, f)
      end
    end

    private

    def ensure_complete_config
      if Suploy::Config.url.nil?
        Suploy::Config.url = Suploy::Util::Ask.ask_for_url
      end
    end

    def config
      @config ||= {}
    end

    def config_file_name
      File.expand_path '~/.suploy'
    end

    module_function :url, :url=, :load, :write, :ensure_complete_config,
      :config, :config_file_name

  end
end
