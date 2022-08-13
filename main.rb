# frozen_string_literal: true

require_relative 'lib/pronounce_array'

pronounces = PronounceArray.parse("凡人にしか,見えねえ風景ってのが社会にはあるんだよ")

pronounces.each do |pronounce|
  p pronounce
end
