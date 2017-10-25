module PoemUtil
  def self.create_poem_id
    require 'securerandom'

    SecureRandom.uuid.delete!('-')
  end
end