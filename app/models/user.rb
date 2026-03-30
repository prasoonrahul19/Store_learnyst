class User < ApplicationRecord
  has_secure_password

  has_many :store1s, foreign_key: :owner_id

  before_save :downcase_email

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, length: { minimum: 6 }

  private

  def downcase_email
    self.email = email.downcase
  end
end