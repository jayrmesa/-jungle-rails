class User < ApplicationRecord
  validates :password, :password_confirmation, length: { minimum: 6 },
  presence: true
  validates_presence_of :email, :first_name, :last_name
  validates :email, :uniqueness => { case_sensitive: false }

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    sanitized_email = email.downcase.strip

    self.find_by(email: sanitized_email)&.authenticate(password)
  end
end
