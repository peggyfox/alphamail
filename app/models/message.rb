class Message < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"

  def sent_date_time
    if DateTime.now.to_date == self.sent_at.to_date
      self.sent_at.strftime('%H:%M')
    else
      self.sent_at.strftime('%m/%d/%y')
    end
  end

  def sender_name
    contact = Contact.find_by(email: self.from_email)
    user = User.find_by(email: self.from_email)
    if contact
      contact.name
    elsif user
      user.name
    else
      nil
    end
  end

  def viewed?
    self.viewed_at != nil
  end

  def self.hashes_to_objects(message_hashes, user)
    message_hashes.map do |message_hash|
      message = Message.new(to_email: user.email, receiver_id: user.id)
      message.from_email = message_hash[:from]
      message.subject = message_hash[:subject]
      message.body = message_hash[:body]
      message.sent_at = message_hash['updated-at'.to_sym]
      message.dbc_id = message_hash[:id]
      message
    end
  end

end
