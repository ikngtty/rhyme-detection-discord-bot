# frozen_string_literal: true

require_relative '../lib/rhyme'

RSpec.describe Rhyme do
  describe '.detect' do
    subject do
      Rhyme.detect(text)
    end

    context 'when the rhymes have 5 sounds' do
      let(:text) { '乾電池で感電死' }

      it 'detects them' do
        is_expected.to eq [%w[カンデンチ カンデンシ]]
      end
    end

    context 'when the rhymes have 7 sounds' do
      let(:text) { '乾電池だけで感電死だね' }

      it 'detects them' do
        is_expected.to eq [%w[カンデンチダケ カンデンシダネ]]
      end
    end

    context 'when the text have 3 rhymes' do
      let(:text) { '乾電池だけで感染したね。更に感電死だね。' }

      it 'detects 2 rhyme pairs' do
        is_expected.to eq [%w[カンデンチダケ カンセンシタネ],
                           %w[カンデンチダケ カンデンシダネ]]
      end
    end

    context 'when the rhymes have the same words' do
      let(:text) { 'あからさまなドジは頭からドジ' }

      it 'detect the rhymes without the words' do
        is_expected.to eq [%w[アカラサマナ ハアタマカラ]] # without ドジ
      end
    end

    context 'when the rhymes have fully same consonant' do
      # Mecab regard オンライン百科事典 as one word.
      let(:text) { 'オンライン百科事典と百科事典' }

      it 'does not detect them' do
        is_expected.to eq []
      end
    end

    context 'when the text have 2 same rhyme pairs' do
      let(:text) { '乾電池で感電死。乾電池で感電死。' }

      it 'detects 1 pair' do
        is_expected.to eq [%w[カンデンチ カンデンシ]]
      end
    end
  end
end
