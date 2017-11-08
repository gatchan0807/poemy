class Poem < ApplicationRecord
  validates :poem_id, uniqueness: true
  belongs_to :follow, foreign_key: :user_id, optional: true

  def self.index_with_count(count)
    self.all.order(created_at: :desc).limit(20 * count)
  end

  def self.index_of_user_with_count(count, user_id)
    self.index_with_count(count).where('user_id = ?', user_id)
  end

  def self.add_reaction(id, reaction_type)
    good, sad, glad, surprised, interested = 1, 2, 3, 4, 5

    @poem = self.where('poem_id = ?', id).first

    case reaction_type
      when good
        @poem.good_counter += 1
      when sad
        @poem.sad_counter += 1
      when glad
        @poem.glad_counter += 1
      when surprised
        # FIXME: タイポ直そうな
        @poem.surprized_counter += 1
      when interested
        # FIXME: タイポ直そうな
        @poem.intrested_counter += 1
      else
        # No action
    end

    @poem.save
  end
end
