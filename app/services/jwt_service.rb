class JwtService
  def self.encode(payload)
    JWT.encode(payload, JWT_SECRET, "HS256")
  end

  def self.decode(token)
    decoded = JWT.decode(token, JWT_SECRET, true, { algorithm: "HS256" })
    decoded[0]
  rescue JWT::DecodeError, JWT::VerificationError
    nil
  end
end
