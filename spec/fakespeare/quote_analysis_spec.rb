# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fakespeare::QuoteAnalysis do
  describe '#nouns' do
    context 'when quote has no nouns' do
      let(:quote) { Fakespeare::Quote.new('jumping') }

      it 'returns an empty array' do
        expect(described_class.new(quote).nouns).to eq([])
      end
    end

    context 'when quote has nouns' do
      let(:quote) { Fakespeare::Quote.new('The bird chased the big black cat') }

      it 'returns an array of nouns' do
        expect(described_class.new(quote).nouns).to eq(%w[bird cat])
      end
    end
  end
end
