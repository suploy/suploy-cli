module Suploy::Error
  class SuployCliError < StandardError; end
  class RemoteDoesNotExist < SuployCliError; end
  class NotAGitRepository < SuployCliError; end
  class RemoteAlreadyExists < SuployCliError; end
end
