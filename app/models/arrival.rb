class Arrival < ApplicationRecord
    belongs_to :trainlines
    belongs_to :stop
    has_many :arrivaltimes
end
