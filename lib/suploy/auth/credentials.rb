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
        netrc = Suploy::Auth::Credentials.netrc
        netrc[Suploy::Api.url] = email, token
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

      def self.netrc
        default = Netrc.default_path
        @netrc ||= Netrc.read default
      end

      def self.from_netrc
        email, token = netrc[Suploy::Api.url]
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
