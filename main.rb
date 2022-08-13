# frozen_string_literal: true

require 'natto'

mecab = Natto::MeCab.new
puts mecab.parse("凡人にしか見えねえ風景ってのがあるんだよ")
