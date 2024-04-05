class Secret < ApplicationRecord
  KEY_LEN = 32
  attr_accessor :password, :password_confirmation

  before_save :encrypt_information

  def decrypt_information(password:)
    errors.add(:password, "can't be blank") if password.blank?
    return false if errors.any?

    begin
      key   = ActiveSupport::KeyGenerator.new(password).generate_key(salt, KEY_LEN)
      crypt = ActiveSupport::MessageEncryptor.new(key)
      crypt.decrypt_and_verify(information)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      errors.add(:password, 'is invalid')
      false
    rescue ActiveSupport::MessageEncryptor::InvalidMessage
      errors.add(:password, 'is invalid')
      false
    end
  end

  private

  def encrypt_information
    errors.add(:password, "can't be blank") if password.blank?
    errors.add(:password_confirmation, "can't be blank") if password_confirmation.blank?
    return if errors.any?

    self.salt = SecureRandom.uuid
    begin
      key   = ActiveSupport::KeyGenerator.new(password).generate_key(salt, KEY_LEN)
      crypt = ActiveSupport::MessageEncryptor.new(key)
      self.information = crypt.encrypt_and_sign(information, expires_in: life_time.minutes)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      errors.add(:password, 'is invalid')
      false
    end
  end
end
