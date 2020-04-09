class Arrival < ApplicationRecord
    belongs_to :trainline
    belongs_to :stop
    has_many :arrivaltimes
end
