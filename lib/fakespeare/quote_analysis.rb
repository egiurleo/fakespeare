# frozen_string_literal: true

require 'engtagger'

module Fakespeare
  class QuoteAnalysis
    def initialize(quote)
      @quote = quote
    end

    def nouns
      @nouns ||=
        tagger.get_nouns(tagged_text).keys - tagger.get_proper_nouns(tagged_text).keys
    end

    private

    def tagger
      @tagger ||= EngTagger.new
    end

    def tagged_text
      return @tagged_text unless @tagged_text.nil?

      @tagged_text = tagger.add_tags(@quote.text)
    end
  end
end
