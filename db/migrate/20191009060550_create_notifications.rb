class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :message
      t.integer :user_id
      t.integer :sender_id
      t.integer :chat_id

      t.timestamps
    end
  end
end
