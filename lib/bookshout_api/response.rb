module Bookshout
  module API
    # This class represents the response to a book fulfillment request. It is a
    # wrapper around an HTTP response, and provides a few convenience methods
    class FulfillmentResponse
      attr_reader :message
      attr_reader :status
      attr_reader :request_id

      # FulfillmentResponse objects should always be initialized directly from
      # the original RestClient::Response object
      def initialize(rest_client_response)
        @status = rest_client_response.code
        json = JSON.parse(rest_client_response.body)

        %w[message request_id].each do |key|
          unless json.key? key
            raise StandardError, "server response missing key: #{key}"
          end
        end

        @message = json['message']
        @request_id = json['request_id']

      rescue JSON::ParserError => parse_error
        @message = "server returned malformed JSON: #{parse_error.message}"
      rescue StandardError => error
        @message = error.message
      end

      # Returns `true` if the request was successful, `false` otherwise. Note
      # that a successful request only means that the fulfillment has been
      # enqueued, it may be several minutes before the user receives their code
      def successful?
        @status == 200
      end
    end
  end
end
