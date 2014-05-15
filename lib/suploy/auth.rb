module Suploy
  class Auth
    def login
      request_credentials
      puts "Authentication successful."
    end

    def request_credentials
      credentials = read_credentials_form_stdin
      token = retrieve_token_from_api credentials[:email], credentials[:password]
      puts "Token: #{token}"
      if token
        @credentials = Suploy::Auth::Credentials.new email, token
        @credentials.save
        @credentials
      else
        puts "Authentication unsuccessful."
        request_credentials
      end
    end

    def read_credentials_form_stdin
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
      response = SuployApi.authenticate(email, password)
      if response.status == 204
        response[:token]
      end
    end

    def get_credentials
      @credentials ||= Suploy::Auth::Credentials.from_netrc
      @credentials ||= request_credentials
      @credentials
    end
  end
end
