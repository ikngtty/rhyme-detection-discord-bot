# frozen_string_literal: true

require_relative 'pronounce_array'

MIN_RHYME_LENGTH = 5

class Rhyme
  class << self
    def detect(text)
      pronounces = PronounceArray.parse(text).to_a
      vowels = get_vowels(pronounces)

      rhymes = []
      (0..(pronounces.length - 2 * MIN_RHYME_LENGTH)).each do |i|
          ((i + MIN_RHYME_LENGTH)..(pronounces.length - MIN_RHYME_LENGTH)).each  do |  j|
          vowels1 = vowels[i...j]
          vowels2 = vowels[j...pronounces.length]
          rhyme_vowels = get_left_rhyme_vowels(vowels1, vowels2)
          if rhyme_vowels.length >= MIN_RHYME_LENGTH
              pronounces1 = pronounces[i...(i + rhyme_vowels.length)]
              pronounces2 = pronounces[j...(j + rhyme_vowels.length)]
              next if pronounces1 == pronounces2
              rhymes.push([pronounces1, pronounces2])
          end
          end
      end
      rhymes
    end

    private

    def get_vowel(pronounce)
      case pronounce
      when 'ア', 'カ', 'ガ', 'サ', 'ザ', 'タ', 'ダ', 'ナ', 'ハ', 'バ', 'パ',
          'マ', 'ヤ', 'ラ', 'ワ', 'キャ', 'ギャ', 'シャ', 'ジャ', 'チャ', 'ヂャ',
          'ニャ', 'ヒャ', 'ビャ', 'ピャ', 'ミャ', 'リャ', 'ヴァ', 'ツァ', 'ヅァ',
          'ファ', 'ァ'
          'ア'
      when 'イ', 'キ', 'ギ', 'シ', 'ジ', 'チ', 'ヂ', 'ニ', 'ヒ', 'ビ', 'ピ', 'ミ',
          'リ', 'ウィ', 'ヴィ', 'ツィ', 'ヅィ', 'ティ', 'ディ', 'フィ', 'ィ'
          'イ'
      when 'ウ', 'ク', 'グ', 'ス', 'ズ', 'ツ', 'ヅ', 'ヌ', 'フ', 'ブ', 'プ',
          'ム', 'ユ', 'ル', 'キュ', 'ギュ', 'シュ', 'ジュ', 'チュ', 'ヂュ',
          'ニュ', 'ヒュ', 'ビュ', 'ピュ', 'ミュ', 'リュ', 'トゥ', 'ドゥ', 'ゥ'
          'ウ'
      when 'エ', 'ケ', 'ゲ', 'セ', 'ゼ', 'テ', 'デ', 'ネ', 'ヘ', 'ベ', 'ペ', 'メ',
          'レ', 'イェ', 'ウェ', 'ヴェ', 'シェ', 'ジェ', 'チェ', 'ヂェ', 'ツェ',
          'ヅェ', 'フェ', 'ェ'
          'エ'
      when 'オ', 'コ', 'ゴ', 'ソ', 'ゾ', 'ト', 'ド', 'ノ', 'ホ', 'ボ', 'ポ',
          'モ', 'ヨ', 'ロ', 'ヲ', 'キョ', 'ギョ', 'ショ', 'ジョ', 'チョ', 'ヂョ',
          'ニョ', 'ヒョ', 'ビョ', 'ピョ', 'ミョ', 'リョ', 'ウォ', 'ヴォ', 'ツォ',
          'ヅォ', 'フォ', 'ォ'
          'オ'
      when 'ン'
          'ン'
      when 'ッ'
          'ッ'
      when 'ー'
          'ー'
      when '*'
          '*'
      else
          raise "invalid pronounce: #{pronounce}"
      end
    end

    def get_vowels(pronounces)
      prev = '*'
      pronounces.map do |pronounce|
          vowel = get_vowel(pronounce)
          vowel = prev if vowel == 'ー'
          prev = vowel
          vowel
      end
    end

    def get_left_rhyme_vowels(vowels1, vowels2)
      ans = []
      length = [vowels1.length, vowels2.length].min
      (0...length).each do |i|
          if vowels1[i] != '*' && vowels1[i] == vowels2[i]
          ans.push(vowels1[i])
          else
          break
          end
      end
      ans
    end
  end
end
