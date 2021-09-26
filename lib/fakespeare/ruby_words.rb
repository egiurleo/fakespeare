# frozen_string_literal: true

module Fakespeare
  module RubyWords
    def self.generate(num)
      words.sample(num)
    end

    def self.words
      YAML.load_file('lib/ruby_words.yml')
    end
  end
end
