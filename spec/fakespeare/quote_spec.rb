# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fakespeare::Quote do
  describe '#replace' do
    let(:quote) { described_class.new('The bird chased the big black cat') }

    context 'when passing an invalid word' do
      it 'raises a Fakespeare::Error' do
        expect do
          quote.replace(1, 'replacement')
        end.to raise_error(Fakespeare::Error, /Word must be a string/)
      end
    end

    context 'when passing an invalid replacement' do
      it 'raises a Fakespeare::Error' do
        expect do
          quote.replace('word', 1)
        end.to raise_error(Fakespeare::Error, /Replacement must be a string/)
      end
    end

    context 'when the quote does not contain the word' do
      it 'returns the original quote' do
        expect(quote.replace('pig', 'dog')).to eq(quote)
      end
    end

    it 'returns a new quote' do
      new_quote = quote.replace('bird', 'dog')
      expect(new_quote.text).to eq('The dog chased the big black cat')
    end
  end

  describe 'replace_many' do
    let(:quote) { described_class.new('The bird chased the big black cat') }

    context 'when words is not an array of strings' do
      it 'raises a Fakespeare::Error' do
        expect do
          quote.replace_many('bird', ['pig'])
        end.to raise_error(Fakespeare::Error, /Words must be an Array/)
      end
    end

    context 'when replacements is not an array of strings' do
      it 'raises a Fakespeare::Error' do
        expect do
          quote.replace_many(['bird'], 'pig')
        end.to raise_error(Fakespeare::Error, /Replacements must be an Array/)
      end
    end

    context 'when a different number of words and replacements is provided' do
      it 'raises a Fakespeare::Error' do
        expect do
          quote.replace_many(['bird'], %w[pig dog])
        end.to raise_error(Fakespeare::Error, /same number of words as replacements/)
      end
    end

    context 'when words and replacements are empty' do
      it 'returns the same quote' do
        expect(quote.replace_many([], [])).to eq(quote)
      end
    end

    context 'when words and replacements are provided' do
      it 'returns a new quote' do
        result = quote.replace_many(%w[bird cat], %w[dog pig])
        expect(result.text).to eq('The dog chased the big black pig')
      end
    end
  end
end
