class CreateArticleTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :article_topics do |t|
      t.references :article, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end

    add_index :article_topics, [:article_id, :topic_id], unique: true
  end
end
