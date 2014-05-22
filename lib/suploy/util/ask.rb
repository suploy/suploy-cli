module Suploy
  module Util
    module Ask
      def ask_for_url
        puts "Enter your Suploy url."
        print "URL (eg. http://suploy.com/): "
        ask("").to_s
      end

      def ask_for_credentials
        puts "Enter your Suploy credentials."
        print "Email: "
        email = ask ""
        print "Password (typing will be hidden): "
        password = ask "" do |q|
          q.echo = false
        end
        {email: email.to_s, password: password.to_s}
      end

      module_function :ask_for_url, :ask_for_credentials
    end
  end
end
