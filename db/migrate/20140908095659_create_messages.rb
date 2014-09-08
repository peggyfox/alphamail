class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to_email
      t.integer :receiver_id
      t.string :from_email
      t.string :subject
      t.text :body
      t.datetime :sent_at
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
