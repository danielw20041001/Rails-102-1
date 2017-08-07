class SportsAssociations < ActiveRecord::Base
    #体育协会要对球员和球队负责，所以体育球队belongs_to球员和球队

    belongs_to :team
    belongs_to :player
end 