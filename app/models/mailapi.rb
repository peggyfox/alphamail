require 'net/http'
require 'nokogiri'

TOKEN = "9fc2a0e83eb63adbb25d3d52f3b28dc6"
ANOTHER_TOKEN = "c9ba90e53425dac9a8f9bcf9ccbcf714"

class MailAPI
  @@base_uri = "http://dbc-mail.herokuapp.com/api"

  def initialize(token, email)
    @token = token
    @email = email
  end

  def get_messages
    response = request_messages
    xml = parse_message_request(response)
    parse_messages(xml)
  end

  def get_messages_test
    response = $response
    xml = parse_message_request(response)
    parse_messages(xml)
  end

  private

    def request_messages
      uri = URI("#{@@base_uri}/#{@email}/messages?api_token=#{@token}")
      Net::HTTP.get(uri)
    end

    def parse_message_request(response)
      Nokogiri::XML::Document.parse(response)
    end

    def parse_messages(xml)
      messages = []
      xml.xpath("//message").each do |message_node|
        message = {}
        message_node.element_children.each do |element|
          message[element.name.to_sym] = element.content
        end
        messages << message
      end
      messages
    end
end

# mail = MailAPI.new(TOKEN, "peggy@alphamail.com")
# puts mail.get_messages
