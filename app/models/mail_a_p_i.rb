class MailError < StandardError

end


class MailAPI
  @@base_uri = "http://dbc-mail.herokuapp.com/api"

  def initialize(token, email)
    @token = token
    @email = email
  end

  def get_messages
    response = request_messages
    xml = parse_request(response)
    parse_messages(xml)
  end

  def get_message_count(max_prev_id)
    response = request_message_count(max_prev_id)
    xml = parse_request(response)
    xml.at_xpath("//count").content.to_i
  end

  def request_message_count(max_prev_id)
    uri = URI("#{@@base_uri}/#{@email}/messages/count?api_token=#{@token}&last_id=#{max_prev_id}")
    server_response = Net::HTTP.get_response(uri)
    code = server_response.code.to_i
    if code != 200
      server_response = handle_error(code, uri, server_response.body)
    end
    server_response.body
  end

  # def get_messages_test
  #   response = $response
  #   xml = parse_request(response)
  #   parse_messages(xml)
  # end

  private




  def request_messages
    uri = URI("#{@@base_uri}/#{@email}/messages?api_token=#{@token}")
    server_response = Net::HTTP.get_response(uri)
    code = server_response.code.to_i
    if code != 200
      server_response = handle_error(code, uri, server_response.body)
    end
    server_response.body
  end

  def handle_error(code, uri, body)
    if code > 499
      server_response = Net::HTTP.get_response(uri)
    else
      raise MailError, "server error #{code}: #{body}"
    end
    server_response
  end

  def parse_request(response)
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
