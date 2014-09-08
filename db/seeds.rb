require 'ffaker'

zac = User.create(email: "zac@alphamail.com", name: "zac", password: "password")
peggy = User.create(email: "peggy@alphamail.com", name: "peggy", password: "password")
zach = User.create(email: "zach@alphamail.com", name: "zach", password: "password")

[zac, peggy, zach].each do |user|
  10.times do
    name = Faker::Name.first_name
    user.contacts.create(email: Faker::Internet.email(name), name: name)
  end

  25.times do
    user.received_messages.create(from_email: Faker::Internet.email, to_email: user.email, subject: Faker::Company.catch_phrase, body: Faker::Lorem.paragraphs(3).join("\n"), sent_at: Time.now, viewed_at: nil)
  end

  10.times do
    user.received_messages.create(from_email: user.contacts.sample.email, to_email: user.email, subject: Faker::Company.catch_phrase, body: Faker::Lorem.paragraphs(3).join("\n") , sent_at: Time.now, viewed_at: nil)
  end

end

