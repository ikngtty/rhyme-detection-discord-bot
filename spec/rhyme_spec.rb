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
  end
end
