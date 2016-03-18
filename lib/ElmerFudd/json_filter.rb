module ElmerFudd
  class JsonFilter
    extend Filter

    def self.setup(handler)
      handler.call_reply_content_type = 'application/json'
    end

    def self.call(env, message, filters)
      message.payload = JSON.parse(message.payload)
      {result: call_next(env, message, filters)}.to_json
    rescue JSON::ParserError
      env.logger.error "Ignoring invalid JSON: #{message.payload}"
    end
  end
end
