module Jekyll
  module Strapi
    class Cache
      def self.request(site, cache_key, &block)
        cache = Jekyll::Strapi::Cache.new(site, cache_key)
        cache.cache_request(&block)
      end

      def initialize(site, cache_key)
        @site = site
        @cache_key = cache_key
      end

      def cache_request(&block)
        if @site.config["strapi"]["cached"] && @site.config["strapi"]["cached"] == true
          cache = Jekyll::Cache.new(cache_name)
          cache.getset(@cache_key) do
            yield
          end
        else
          Jekyll::Cache.clear
          yield
        end
      end

      def cache_name
        # Define custom logic in your _plugins/file_name.rb
        "strapi"
      end
    end
  end
end
