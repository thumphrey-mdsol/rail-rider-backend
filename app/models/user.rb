class User < ApplicationRecord
    has_many :favorites
    has_many :stops, through: :favorites
end
