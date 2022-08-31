# frozen_string_literal: true

require_relative 'word_pronounce_array'
require_relative 'vowel'

MIN_RHYME_LENGTH = 5

class Rhyme
  class << self
    def detect(text)
      word_pronounces = WordPronounceArray.parse(text)
      pronounces = word_pronounces.body.map(&:pronounce)
      vowels = Vowel.get_vowels(pronounces)

      rhyme_ranges = []
      (0..(pronounces.length - 2 * MIN_RHYME_LENGTH)).each do |i|
        ((i + MIN_RHYME_LENGTH)..(pronounces.length - MIN_RHYME_LENGTH)).each do |j|
          rhyme_length = get_left_rhyme_length(word_pronounces, vowels, i...j, j...pronounces.length)
          next if rhyme_length == 0

          range1 = i...(i + rhyme_length)
          range2 = j...(j + rhyme_length)
          pronounces1 = pronounces[range1]
          pronounces2 = pronounces[range2]
          next if pronounces1 == pronounces2

          covered = [range1, range2].all? do |range|
            rhyme_ranges.any? do |found_ranges|
              found_ranges.any? do |found_range|
                found_range.cover?(range)
              end
            end
          end
          next if covered

          doubled = rhyme_ranges.any? do |found_range1, found_range2|
            found_pronounces1 = pronounces[found_range1]
            found_pronounces2 = pronounces[found_range2]
            (pronounces1 == found_pronounces1 && pronounces2 == found_pronounces2) ||
              (pronounces1 == found_pronounces2 && pronounces2 == found_pronounces1)
          end
          next if doubled

          rhyme_ranges.push([range1, range2])
        end
      end
      rhyme_ranges.map do |range1, range2|
        [pronounces[range1].join(''), pronounces[range2].join('')]
      end
    end

    private

    def get_left_rhyme_length(word_pronounces, vowels, range1, range2)
      vowels1 = vowels[range1]
      vowels2 = vowels[range2]
      rhyme_length = 0
      return rhyme_length if vowels1[0] == 'ン'

      length = [vowels1.length, vowels2.length].min
      (0...length).each do |i|
        if vowels1[i] != '*' && vowels1[i] == vowels2[i]
          rhyme_length += 1
        else
          break
        end
      end
      return 0 if rhyme_length < MIN_RHYME_LENGTH

      words1 = word_pronounces.words_in(range1.begin...(range1.begin + rhyme_length))
      words2 = word_pronounces.words_in(range2.begin...(range2.begin + rhyme_length))
      words1.each do |word1|
        words2.each do |word2|
          if word1.word == word2.word && word1.part_of_speech == word2.part_of_speech
            rhyme_length = [rhyme_length, word1.position.begin, word2.position.begin].min
          end
        end
      end
      return 0 if rhyme_length < MIN_RHYME_LENGTH

      rhyme_length
    end
  end
end
