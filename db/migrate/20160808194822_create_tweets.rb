class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    t.belongs_to :user, index: true
    t.string :tweet
    t.timestamps
  end
end
end
