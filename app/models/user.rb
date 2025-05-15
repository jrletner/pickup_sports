class User < ApplicationRecord
  # set up required columns
  validates :username, :email, :first_name, :last_name, presence: true
  # set up unique columns
  validates :username, :email, uniqueness: true
  # set up min / max character lengths
  validates :first_name, :last_name, :email, :username, length: { minimum: 1, maximum: 100 }
  # set up email validation
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validate the username
  validate :validate_username

  private
  def validate_username
    unless username =~ /\A[a-zA-Z0-9_]+\Z/
      errors.add(:username, "can only contain letters, numbers, and underscores, and must also contain one letter or number")
    end
  end
end
