class CreatePoems < ActiveRecord::Migration[5.1]
  def change
    create_table :poems do |t|
      t.string :poem_id
      t.text :content
      t.string :user_id
      t.integer :good_counter, default: 0
      t.integer :sad_counter, default: 0
      t.integer :glad_counter, default: 0
      t.integer :surprized_counter, default: 0
      t.integer :intrested_counter, default: 0
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
