class Poem < ApplicationRecord
  validates :poem_id, uniqueness: true
  belongs_to :follow, foreign_key: :user_id

  def self.index_with_count(count)
    self.all.order(created_at: :desc).limit(20 * count)
  end

  def self.index_of_user_with_count(count, user_id)
    self.index_with_count(count).where('user_id = ?', user_id)
  end
end
