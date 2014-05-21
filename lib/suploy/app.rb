module Suploy
  module App
    def init(app_name)
      if app_name.nil?
        raise ArgumentError.new "You have to provide a name for an app to be created."
      end
      app = Suploy::Api::App.create app_name
      add_suploy_remote app.info['repository']
      puts "Initialized suploy. You can now deploy using git."
    rescue Rugged::RepositoryError
      raise Suploy::NotAGitRepository.new "Current directory is not a git repository, cannot initialize suploy."
    end

    def info
      # Get app from suploy api
      app = Suploy::Api::App.get suploy_app_name
      # Format it nicely to stdout
      puts "Name:   #{app.info['name']}\n"
      puts "Status: #{app.info['status']}\n"
      puts "Repo:   #{app.info['repository']}"
    end

    def index
      # Get app array through suploy api
      apps = Suploy::Api::App.index
      # Create an ascii table based on results
      table = Terminal::Table.new
      table.title = "Apps: #{apps.size}"
      table.headings = ['Name', 'Status', 'Repository']
      table.rows = apps.map do |a|
        [a.info["name"], a.info["status"], a.info["repository"]]
      end
      # print the table to stdout
      puts table
    end

    def add_suploy_remote(git_url)
      repo = current_git_repo
      remote = 'suploy'
      Rugged::Remote.add(repo, remote, git_url)
    rescue Rugged::ConfigError
      raise RemoteAlreadyExists.new, "Remote 'suploy' already exists."
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
        raise Suploy::Error::RemoteDoesNotExist.new, "No suploy remote found."
      end
      @suploy_remote
    end

    module_function :init, :info, :index, :add_suploy_remote, :current_git_repo,
      :suploy_app_name, :suploy_remote
  end
end
