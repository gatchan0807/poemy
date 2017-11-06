class Formatter
  def self.index_on_poems(poem)
    {
        id:         poem.poem_id,
        user_id:    poem.user_id,
        contents:   poem.content,
        created_at: poem.created_at,
        good:       poem.good_counter,
        sad:        poem.sad_counter,
        surprized:  poem.surprized_counter,
        intrested:  poem.intrested_counter
    }
  end
end