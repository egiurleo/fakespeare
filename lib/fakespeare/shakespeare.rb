# frozen_string_literal: true

require 'net/http'

module Fakespeare
  module Shakespeare
    class Error < StandardError; end

    class Client
      BASE_URL = 'shakespearean-quote-generator.herokuapp.com'
      API_PATH = 'quote'

      def generate_quote
        uri = URI.parse("http://#{BASE_URL}/#{API_PATH}")
        response = Net::HTTP.get_response(uri)

        return response.body if response.is_a?(Net::HTTPSuccess)

        raise(
          Shakespeare::Error,
          "There was an error with the call to the Shakespeare API: #{response.message}"
        )
      end
    end
  end
end
