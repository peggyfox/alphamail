class Contact < ActiveRecord::Base
  belongs_to :user

  def messages
    Messages.where(from_email: self.email)
  end
end
