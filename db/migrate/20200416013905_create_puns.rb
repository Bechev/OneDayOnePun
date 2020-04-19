class CreatePuns < ActiveRecord::Migration[5.2]
  def change
    create_table :puns do |t|
        t.string :tweet
        t.boolean :is_published, default: :false
        t.date :publication_date
        t.integer :likes, default: 0
        t.integer :retweets, default: 0
        t.integer :tweet_id, limit: 8
      t.timestamps
    end
  end
end
