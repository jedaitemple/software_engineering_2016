class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.text :name
      t.integer :total_score
      
      t.timestamps
    end
  end
end
