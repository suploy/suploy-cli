module Suploy
  module Auth
    def login
      ask_for_and_save_credentials
      puts "Authentication successful."
    end

    def ask_for_and_save_credentials
      credentials = ask_for_credentials
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

    def ask_for_credentials
      puts "Enter your Suploy credentials."
      print "Email: "
      email = ask ""
      print "Password (typing will be hidden): "
      password = ask "" do |q|
        q.echo = false
      end
      {email: email, password: password}
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

    module_function :login, :ask_for_and_save_credentials,
    :ask_for_credentials, :retrieve_token_from_api,
    :get_credentials
  end
end
