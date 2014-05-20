module Suploy::Error
  class SuployCliError < StandardError; end
  class RemoteDoesNotExist < SuployCliError; end
  class NotAGitRepository < SuployCliError; end
end
