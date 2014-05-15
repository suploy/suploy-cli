module Suploy
  class App
    def self.init
      #app = SuployApi::App.create
      self.add_suploy_remote 'git://github.com/libgit2/libgit2.git' # remove this when SuployApi is ready
      puts "Initialized suploy. You can now deploy using git."
    rescue Rugged::RepositoryError
      puts "Current directory is not a git repository, cannot initialize suploy."
    end

    def self.add_suploy_remote(git_url)
      repo = self.current_git_repo
      remote = 'suploy'
      Rugged::Remote.add(repo, remote, git_url)
    end

    def self.current_git_repo
      git_dir = Rugged::Repository.discover
      Rugged::Repository.new git_dir
    end
  end
end
