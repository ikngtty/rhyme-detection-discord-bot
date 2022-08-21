# frozen_string_literal: true

WordPronounce = Struct.new(:word, :part_of_speech, :pronounce,
                           :position_in_word, keyword_init: true)
