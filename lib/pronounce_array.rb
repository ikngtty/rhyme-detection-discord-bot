# frozen_string_literal: true

require 'natto'

class PronounceArray
  include Enumerable

  def self.parse(text)
    mecab = Natto::MeCab.new
    pronounce_text = mecab.enum_parse(text).map do |node|
      node.feature.split(',')[7] || '*'
    end.join('')
    self.new(pronounce_text)
  end

  def initialize(text)
    @text = text
  end

  def each
    pos = 0
    while pos < @text.length
      if %w(キ ギ シ ジ チ ヂ ニ ヒ ビ ピ ミ リ).include?(@text[pos]) &&
        %w(ャ ュ ョ).include?(@text[pos+1])
        yield @text[pos..pos+1]
        pos += 2
      else
        yield @text[pos]
        pos += 1
      end
    end
  end
end
