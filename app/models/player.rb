class Player < ActiveRecord::Base
    # 先告诉model我们在体育协会有很多笔资料

    has_many :sports_associations
  # 这些资料是要拿来判断这个球员有参与多少球队

    has_many :teams, :through => :sports_associations
end 