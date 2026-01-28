JWT_SECRET = Rails.application.credentials.jwt_secret || ENV.fetch("JWT_SECRET", "development_secret_key_change_in_production")
