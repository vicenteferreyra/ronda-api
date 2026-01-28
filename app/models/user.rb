class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, presence: true, if: -> { new_record? && provider == "email" }
  validates :provider_uid, uniqueness: { scope: :provider, allow_nil: true }, if: -> { provider != "email" }

  def generate_jwt
    JwtService.encode(user_id: id)
  end
end
