# frozen_string_literal: true

require_relative 'lib/pronounce_array'

def get_vowel(pronounce)
  case pronounce
  when 'ア', 'カ', 'ガ', 'サ', 'ザ', 'タ', 'ダ', 'ナ', 'ハ', 'バ', 'パ',
    'マ', 'ヤ', 'ラ', 'ワ', 'キャ', 'ギャ', 'シャ', 'ジャ', 'チャ', 'ヂャ',
    'ニャ', 'ヒャ', 'ビャ', 'ピャ', 'ミャ', 'リャ'
    'ア'
  when 'イ', 'キ', 'ギ', 'シ', 'ジ', 'チ', 'ヂ', 'ニ', 'ヒ', 'ビ', 'ピ', 'ミ',
    'リ'
    'イ'
  when 'ウ', 'ク', 'グ', 'ス', 'ズ', 'ツ', 'ヅ', 'ヌ', 'フ', 'ブ', 'プ',
    'ム', 'ユ', 'ル', 'キュ', 'ギュ', 'シュ', 'ジュ', 'チュ', 'ヂュ',
    'ニュ', 'ヒュ', 'ビュ', 'ピュ', 'ミュ', 'リュ'
    'ウ'
  when 'エ', 'ケ', 'ゲ', 'セ', 'ゼ', 'テ', 'デ', 'ネ', 'ヘ', 'ベ', 'ペ', 'メ',
    'レ'
    'エ'
  when 'オ', 'コ', 'ゴ', 'ソ', 'ゾ', 'ト', 'ド', 'ノ', 'ホ', 'ボ', 'ポ',
    'モ', 'ヨ', 'ロ', 'ヲ', 'キョ', 'ギョ', 'ショ', 'ジョ', 'チョ', 'ヂョ',
    'ニョ', 'ヒョ', 'ビョ', 'ピョ', 'ミョ', 'リョ'
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

pronounces = PronounceArray.parse('チョーカー').to_a
p get_vowels(pronounces)
