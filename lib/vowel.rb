# frozen_string_literal: true

class Vowel
  class << self
    def get_vowel(pronounce)
      case pronounce
      when 'ア', 'カ', 'ガ', 'サ', 'ザ', 'タ', 'ダ', 'ナ', 'ハ', 'バ', 'パ',
        'マ', 'ヤ', 'ラ', 'ワ', 'キャ', 'ギャ', 'シャ', 'ジャ', 'チャ', 'ヂャ',
        'ニャ', 'ヒャ', 'ビャ', 'ピャ', 'ミャ', 'リャ', 'ヴァ', 'ツァ', 'ヅァ',
        'ファ', 'ァ'
        'ア'
      when 'イ', 'キ', 'ギ', 'シ', 'ジ', 'チ', 'ヂ', 'ニ', 'ヒ', 'ビ', 'ピ', '',
        'リ', 'ウィ', 'ヴィ', 'ツィ', 'ヅィ', 'ティ', 'ディ', 'フィ', 'ィ'
        'イ'
      when 'ウ', 'ク', 'グ', 'ス', 'ズ', 'ツ', 'ヅ', 'ヌ', 'フ', 'ブ', 'プ',
        'ム', 'ユ', 'ル', 'キュ', 'ギュ', 'シュ', 'ジュ', 'チュ', 'ヂュ',
        'ニュ', 'ヒュ', 'ビュ', 'ピュ', 'ミュ', 'リュ', 'トゥ', 'ドゥ', 'ゥ'
        'ウ'
      when 'エ', 'ケ', 'ゲ', 'セ', 'ゼ', 'テ', 'デ', 'ネ', 'ヘ', 'ベ', 'ペ', '',
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
      else
        '*'
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
  end
end
