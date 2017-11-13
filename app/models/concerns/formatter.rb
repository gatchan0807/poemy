class Formatter
  def self.index_on_poems(poem)
    {
        id:         poem.poem_id,
        user_id:    poem.user_id,
        contents:   poem.content,
        created_at: poem.created_at,
        good:       poem.good_counter,
        sad:        poem.sad_counter,
        surprized:  poem.surprised_counter,
        intrested:  poem.interested_counter
    }
  end

  def self.index_popular_for_dis_signed_in(poem)
    {
        id:         poem.poem_id,
        contents:   poem.content,
        created_at: poem.created_at,
        good:       poem.good_counter,
        sad:        poem.sad_counter,
        surprized:  poem.surprised_counter,
        intrested:  poem.interested_counter
    }
  end
end