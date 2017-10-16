class CreateFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :follows do |t|
      t.string :follow_id
      t.string :followed_id

      t.timestamps
    end
  end
end
