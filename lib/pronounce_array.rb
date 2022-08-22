# frozen_string_literal: true

class PronounceArray
  include Enumerable

  def initialize(text)
    @text = text
  end

  def each
    pos = 0
    while pos < @text.length
      if (%w[キ ギ シ ジ チ ヂ ニ ヒ ビ ピ ミ リ].include?(@text[pos]) &&
        @text[pos + 1] == 'ャ') ||
         (%w[ヴ キ ギ シ ジ チ テ ヂ デ ニ ヒ フ ビ ブ ピ ミ リ].include?(@text[pos]) &&
         @text[pos + 1] == 'ュ') ||
         (%w[キ ギ シ ジ チ ヂ ニ ヒ ビ ピ ミ リ].include?(@text[pos]) &&
         @text[pos + 1] == 'ョ') ||
         (%w[ヴ ツ ヅ フ].include?(@text[pos]) && @text[pos + 1] == 'ァ') ||
         (%w[ウ ヴ ツ ヅ テ デ フ].include?(@text[pos]) &&
         @text[pos + 1] == 'ィ') ||
         (%w[ト ド].include?(@text[pos]) && @text[pos + 1] == 'ゥ') ||
         (%w[イ ウ ヴ シ ジ チ ヂ ツ ヅ フ].include?(@text[pos]) &&
         @text[pos + 1] == 'ェ') ||
         (%w[ウ ヴ ツ ヅ フ].include?(@text[pos]) && @text[pos + 1] == 'ォ')
        yield @text[pos..pos + 1]
        pos += 2
      else
        yield @text[pos]
        pos += 1
      end
    end
  end
end
