class User < ApplicationRecord
  has_secure_password


  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save :downcase_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  private

  def downcase_email
    self.email = email.downcase
  end
end
