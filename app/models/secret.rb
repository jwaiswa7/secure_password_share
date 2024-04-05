class Secret < ApplicationRecord
  attr_accessor :password, :password_confirmation

  before_save :encrypt_information

  private

  def encrypt_information
    errors.add(:password, 'can not be blank') if information.blank?
    errors.add(:password, 'does not match') if password != password_confirmation
    self.information = BCrypt::Password.create(information)
  end
end
