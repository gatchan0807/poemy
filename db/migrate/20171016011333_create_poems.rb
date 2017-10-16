class CreatePoems < ActiveRecord::Migration[5.1]
  def change
    create_table :poems do |t|
      t.string :poem_id
      t.text :content
      t.string :user_id
      t.integer :good_counter
      t.integer :sad_counter
      t.integer :glad_counter
      t.integer :surprized_counter
      t.integer :intrested_counter
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
