module PoemUtil
  def self.create_poem_id
    require 'securerandom'

    SecureRandom.uuid.delete!('-')
  end

  def self.is_reacted(poem_id, reacted_list)
    response = false

    reacted_list.each { |reacted|
      if reacted == poem_id
        response = true
      end
    }

    response
  end

end