# frozen_string_literal: true

module MoexIss
  class Error < StandardError
    ResponseSchemaError = Class.new(self)
    ResponseParseError = Class.new(self)
    InvalidDateError = Class.new(self)

    ClientError = Class.new(self)
    ServerError = Class.new(self)

    BadRequest = Class.new(ClientError)
    Unauthorized = Class.new(ClientError)
    NotAcceptable = Class.new(ClientError)
    NotFound = Class.new(ClientError)
    Conflict = Class.new(ClientError)
    TooManyRequests = Class.new(ClientError)
    Forbidden = Class.new(ClientError)
    Locked = Class.new(ClientError)
    MethodNotAllowed = Class.new(ClientError)

    NotImplemented = Class.new(ServerError)
    BadGateway = Class.new(ServerError)
    ServiceUnavailable = Class.new(ServerError)
    GatewayTimeout = Class.new(ServerError)

    ERRORS = {
      400 => MoexIss::Error::BadRequest,
      401 => MoexIss::Error::Unauthorized,
      403 => MoexIss::Error::Forbidden,
      404 => MoexIss::Error::NotFound,
      405 => MoexIss::Error::MethodNotAllowed,
      406 => MoexIss::Error::NotAcceptable,
      409 => MoexIss::Error::Conflict,
      423 => MoexIss::Error::Locked,
      429 => MoexIss::Error::TooManyRequests,
      500 => MoexIss::Error::ServerError,
      502 => MoexIss::Error::BadGateway,
      503 => MoexIss::Error::ServiceUnavailable,
      504 => MoexIss::Error::GatewayTimeout
    }.freeze
  end
end
