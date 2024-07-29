class User < ApplicationRecord

  USER_PARAMS = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = Regexp.new(Settings.user.valid_email)

  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings.user.maxlength_user_name}
  validates :email, presence: true,
    length: {maximum: Settings.user.maxlength_user_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end