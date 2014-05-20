module Suploy::Api::Error
  class SuployCliError < StandardError; end
  class SuployRemoteDoesNotExist < SuployCliError; end
end
