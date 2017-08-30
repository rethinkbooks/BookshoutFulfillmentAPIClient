require 'yaml'
require 'json'
require 'rest-client'

require 'bookshout_api/version'
require 'bookshout_api/response'

module Bookshout
  module API
    # This is the BookShout Fulfillment API Client gem, it can be used to
    # generate and send book codes to an email address.
    #
    # This gem is provides a simple wrapper around the HTTP version of the API.
    #
    # To use this API, you will need a valid API key, speak to your BookShout
    # representative if you don't already have one.
    #
    # Usage
    #
    # ```ruby
    # client = Bookshout::API::FulfillmentClient.new('<your api key here>')
    # response = client.send_book(isbn: '9781250075598',
    #                             email: 'jerry.horne@example.com')
    #
    # if response.successful?
    #  puts "all is well, user will receive code shortly"
    # else
    #  puts "something went wrong:"
    #  puts response.message
    # end
    # ```
    class FulfillmentClient
      def initialize(api_key)
        @api_key = api_key
      end

      # Expects the ISBN13 identifier for a book, and the email the code will be
      # sent to.
      # Returns an instance of Bookshout::API::FulfillmentResponse
      def send_book(isbn:, email:)
        begin
          response = rest_client.execute(method: :post,
                                         url: fulfillment_url(isbn),
                                         headers: headers,
                                         payload: email)
        rescue RestClient::Forbidden,
               RestClient::NotFound,
               RestClient::InternalServerError => err
          response = err.response
        end

        FulfillmentResponse.new(response)
      end

      private

      def fulfillment_url(isbn)
        "#{host}/production/books/#{isbn}"
      end

      def headers
        @headers ||= { 'x-api-key' => api_key }
      end

      def config
        @config ||= YAML.load_file(File.join(__dir__, 'config.yml'))
      end

      def rest_client
        @rest_client ||= RestClient::Request
      end

      def api_key
        @api_key ||= raise ArgumentError, 'nil or invalid API key'
      end

      # Returns the API host that has the fulfillment endpoints; if the
      # environment variable BOOKSHOUT_FULFILLMENT_HOST is present, it will
      # override any other configuration
      def host
        ENV['BOOKSHOUT_FULFILLMENT_HOST'] || config['host']
      end
    end
  end
end
