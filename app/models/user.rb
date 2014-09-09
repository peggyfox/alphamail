class User < ActiveRecord::Base
  has_many :contacts
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  validates :name, :length => { :minimum => 3, :message => "must be at least 3 characters" }
  validates :email, :uniqueness => true, :format => /.+@.+\.\D{2,}/

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end

  def sent_messages
    Messages.where(from_email: self.email)
  end


  def fetch_messages
    mail = MailAPI.new(TOKEN, self.email)
    max_prev_id = self.received_messages.length == 0 ? 0 : self.received_messages.all.order(dbc_id: :desc).first.dbc_id
    messages = []
    if mail.get_message_count(max_prev_id) > 0
      message_hashes = mail.get_messages
      messages = Message.hashes_to_objects(message_hashes, self)
      messages.sort { |m_1, m_2| m_1.dbc_id <=> m_2.dbc_id }
      messages.each do |message|
        message.save if message.dbc_id > max_prev_id
      end
    end
  end

end
