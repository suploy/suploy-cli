module Suploy
  module Auth
    class Credentials
      attr_accessor :email
      attr_accessor :token

      def initialize(email, token)
        @email = email
        @token = token
      end

      def save
        netrc = Netrc.read
        netrc[Suploy::Config.host] = user, token
        netrc.save
      end

      def meet_requirements?
        email_valid? && token_valid?
      end

      def email_valid?
        !email.nil? && !email.empty?
      end

      def token_valid?
        !token.nil? && !token.empty?
      end

      def self.from_netrc
        netrc = Netrc.read
        email, token = netrc[Suploy::Config.host]
        credentials = Credentials.new email, token
        if credentials.meet_requirements?
          credentials
        else
          nil
        end
      end
    end
  end
end
