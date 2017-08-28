# BookshoutFulfillmentAPIClient

This is the Bookshout Fulfillment API client gem, it can be used to request that
a book code be sent to an email address.

This gem provides a simple wrapper around the HTTP version of the API.

To use this API, you will need a valid API key, speak to your BookShout
representative if you don't already have one.

## Usage

```ruby
client = Bookshout::API::FulfillmentClient.new(api_key: '<your api key here>')
response = client.send_book(isbn: '9781250075598', email: 'jerry.horne@example.com')

if response.successful?
  puts "all is well, user will receive code shortly"
else
  puts "something went wrong:"
  puts response.message
end
```
