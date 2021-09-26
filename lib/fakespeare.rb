# frozen_string_literal: true

require_relative 'fakespeare/version'
require_relative 'fakespeare/shakespeare'
require_relative 'fakespeare/quote'
require_relative 'fakespeare/quote_analysis'
require_relative 'fakespeare/ruby_words'

require 'yaml'

module Fakespeare
  class Error < StandardError; end

  def self.generate_quote
    begin
      quote = Quote.new(Shakespeare::Client.new.generate_quote)
    rescue Shakespeare::Error => e
      raise Fakespeare::Error.new(e.message)
    end

    analysis = QuoteAnalysis.new(quote)

    num_words = (analysis.nouns.length / 2.0).ceil

    words = analysis.nouns.sample(num_words)
    replacements = RubyWords.generate(num_words)

    quote.replace_many(words, replacements).text
  end
end
