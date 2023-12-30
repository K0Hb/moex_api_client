# frozen_string_literal: true

module MoexIss
  module Request
    include MoexIss::Connection

    def get(path, params = {})
      respond_with(connection.get(path, params))
    end

    private

    def respond_with(raw_response)
      return if raw_response.body.empty?

      respond_with_error(raw_response.status, raw_response.body) if !raw_response.success?

      JSON.parse(raw_response.body)
    rescue JSON::ParserError
      raise MoexIss::Error::ResponseParseError, "Ошибка парсинга json из ответа"
    end

    def respond_with_error(code, body)
      fail(MoexIss::Error, body) unless MoexIss::Error::ERRORS.key?(code)

      fail MoexIss::Error::ERRORS[code], body
    end
  end
end
