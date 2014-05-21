module Suploy
  module Auth
    def login
      ask_for_and_save_credentials
      puts "Authentication successful."
    end

    def ask_for_and_save_credentials
      credentials = Suploy::Util::Ask.ask_for_credentials
      token = retrieve_token_from_api credentials[:email], credentials[:password]
      if token
        @credentials = Suploy::Auth::Credentials.new credentials[:email], token
        @credentials.save
        @credentials
      else
        puts "Authentication unsuccessful."
        ask_for_and_save_credentials
      end
    end

    def retrieve_token_from_api(email, password)
      response = Suploy::Api::Credentials.login(email, password)
      response.info["user_token"]
    end

    def get_credentials
      @credentials ||= Suploy::Auth::Credentials.from_netrc
      @credentials ||= ask_for_and_save_credentials
      @credentials
    end

    def set_authorization_for(commands_requiring_auth, current_command)
      parent_most_command = current_command.topmost_ancestor.names
      if commands_requiring_auth.include? parent_most_command
        token = Suploy::Auth.get_credentials.token
        Suploy::Api.authorization token
      end
    end

    module_function :login, :ask_for_and_save_credentials,
    :retrieve_token_from_api, :get_credentials, :set_authorization_for
  end
end
