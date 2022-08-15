# frozen_string_literal: true

require_relative '../lib/rhyme'

RSpec.describe Rhyme do
  describe '.detect' do
    subject do
      Rhyme.detect(text)
    end

    context '5 length rhyme' do
      let(:text) { '乾電池で感電死' }
      it { is_expected.to eq [['カンデンチ', 'カンデンシ']] }
    end

    context '7 length rhyme' do
      let(:text) { '乾電池だけで感電死だね' }
      it { is_expected.to eq [['カンデンチダケ', 'カンデンシダネ']] }
    end

    context '3 rhymes' do
      let(:text) { '乾電池だけで感染したね。更に感電死だね。' }
      it { is_expected.to eq [['カンデンチダケ', 'カンセンシタネ'],
                              ['カンデンチダケ', 'カンデンシダネ']] }
    end
  end
end
