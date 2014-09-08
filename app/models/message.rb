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

end
