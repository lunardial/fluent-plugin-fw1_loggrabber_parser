# -*- coding: utf-8 -*-

module Fluent
  class TextParser
    
    class Fw1LoggrabberParser < Parser
      
      # Register this parser as a parser plugin
      Plugin.register_parser('fw1_loggrabber', self)

      # This method is called after config_params have read configuration parameter
      def initialize
        super
        @pattern_key_value = /(?<=^|[^\\]\|)([^=\s]+)=((?:[^|]|(?:(?<=\\)\|))+)/
      end

      def configure(conf={})
        super
      end

      def parse(text)
        record = logparse(text)
        yield Engine.now, record
      end


      def logparse(text)

        return {} if (nil == text)

        record = Hash.new

        begin
          for pair in text.scan(@pattern_key_value) do
            record[pair[0]] = pair[1]
          end
        rescue => e
          log.error e.message
          return {}
        end

        return record
      end

    end

  end

end
