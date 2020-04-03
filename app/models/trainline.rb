class Trainline < ApplicationRecord
    has_many :arrivals
    has_many :stops, through: :arrivals
end
