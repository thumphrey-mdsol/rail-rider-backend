class Stop < ApplicationRecord
    has_many :favorites
    has_many :users, through: :favorites
    has_many :arrivals
    has_many :trainlines, through: :arrivals
end
