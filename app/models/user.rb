class User < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 50 }

  has_secure_password
end
