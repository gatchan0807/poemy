class Poem < ApplicationRecord
  validates :poem_id, uniqueness: true

  def self.index_with_count(count)
    self.all.order(created_at: :desc).limit(20 * count)
  end
end
