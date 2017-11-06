class Follow < ApplicationRecord
  has_many :poems, foreign_key: :user_id, primary_key: :follow_id
end
