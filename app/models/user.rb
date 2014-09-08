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


end
