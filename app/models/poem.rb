class Poem < ApplicationRecord
  validates :poem_id, uniqueness: true
  belongs_to :follow, foreign_key: :user_id, optional: true

  def self.index_with_count(count)
    self.all.order(created_at: :desc).limit(20 * count)
  end

  def self.index_of_user_with_count(count, user_id)
    self.index_with_count(count).where('user_id = ?', user_id)
  end

  def self.index_by_popular(count)
    self.all
        .select(
            'poems.*, (good_counter + sad_counter + glad_counter + surprised_counter + interested_counter) as total'
        )
        .order('total desc').limit(2 * count)
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
        @poem.surprised_counter += 1
      when interested
        @poem.interested_counter += 1
      else
        # No action
    end

    @poem.save
  end
end
