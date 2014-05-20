module Suploy
  module App
    def init(app_name)
      app = Suploy::Api::App.create app_name
      add_suploy_remote app.info['repository']
      puts "Initialized suploy. You can now deploy using git."
    rescue Rugged::RepositoryError
      puts "Current directory is not a git repository, cannot initialize suploy."
    end

    def info(app_name=suploy_app_name)
      app = Suploy::Api::App.get app_name
    end

    def index
      apps = Suploy::Api::App.index
    end

    def add_suploy_remote(git_url)
      repo = current_git_repo
      remote = 'suploy'
      Rugged::Remote.add(repo, remote, git_url)
    end

    def current_git_repo
      git_dir = Rugged::Repository.discover
      @repo ||= Rugged::Repository.new git_dir
    end

    def suploy_app_name
      suploy_remote.url.split(':').last
    end

    def suploy_remote
      @suploy_remote ||= Rugged::Remote.lookup(current_git_repo, 'suploy')
      if @suploy_remote.nil?
        raise SuployRemoteDoesNotExist, "No suploy remote found."
      end
      @suploy_remote
    end

    module_function :init, :info, :index, :add_suploy_remote, :current_git_repo,
      :suploy_app_name, :suploy_remote
  end
end
