class User < ApplicationRecord
    has_many :favorites
    has_many :stops, through: :favorites

    validates :username, uniqueness: true

    has_secure_password
end
