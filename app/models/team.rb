class Team < ActiveRecord::Base
    has_many :sports_associations
    has_many :players, :through => :sports_associations
end 