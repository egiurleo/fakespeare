# frozen_string_literal: true

module Fakespeare
  module Cache
    def self.set(quote)
      return true if cache_table[quote]

      cache_table[quote] = true
    end

    def self.get
      cache_table.empty? ? nil : cache_table.sample
    end

    private

    # Taken from: https://github.com/mongodb/mongo-ruby-driver/blob/master/lib/mongo/query_cache.rb
    def self.cache_table
      Thread.current["fakespeare_cache"] ||= {}
    end
  end
end
