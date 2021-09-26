# frozen_string_literal: true

module Fakespeare
  class Quote
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def replace(word, replacement)
      raise Fakespeare::Error, 'Word must be a string' unless word.is_a?(String)
      raise Fakespeare::Error, 'Replacement must be a string' unless replacement.is_a?(String)

      return self unless @text.include?(word)
      return self if word.empty? || replacement.empty?

      Quote.new(@text.gsub(word, replacement))
    end

    def replace_many(words, replacements)
      raise Fakespeare::Error, 'Words must be an Array' unless words.is_a?(Array)
      raise Fakespeare::Error, 'Replacements must be an Array' unless replacements.is_a?(Array)

      unless words.length == replacements.length
        raise Fakespeare::Error, 'Must provide the same number of words as replacements'
      end

      return self if words.empty? && replacements.empty?

      current_quote = self

      words.zip(replacements).each do |word, replacement|
        # rubocop:disable Style/RedundantSelfAssignment
        current_quote = current_quote.replace(word, replacement)
        # rubocop:enable Style/RedundantSelfAssignment
      end

      current_quote
    end
  end
end
