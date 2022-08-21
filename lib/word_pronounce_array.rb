# frozen_string_literal: true

require 'natto'

require_relative 'pronounce_array'
require_relative 'word_position'
require_relative 'word_pronounce'

class WordPronounceArray
  class << self
    def parse(text)
      mecab = Natto::MeCab.new
      body = mecab.enum_parse(text).flat_map do |node|
        word = node.surface
        features = node.feature.split(',')
        part_of_speech = features[0]
        PronounceArray.new(features[7] || '*').map.with_index do |pronounce, i|
          WordPronounce.new(word:, part_of_speech:,
                            pronounce:, position_in_word: i)
        end
      end
      new(body)
    end
  end

  attr_reader :body

  def initialize(body)
    @body = body
  end

  def words_in(range)
    word_pronounces = @body[range]
    word_pronounces << WordPronounce.new(position_in_word: 0)
    word_position = 0
    words = []
    word_pronounces.each_cons(2).with_index do |(word_pronounce, next_word_pronounce), i|
      if word_pronounce.position_in_word >= next_word_pronounce.position_in_word
        words << WordPosition.new(word: word_pronounce.word,
                                  part_of_speech: word_pronounce.part_of_speech,
                                  position: word_position..i)
        word_position = i + 1
      end
    end
    words
  end
end
