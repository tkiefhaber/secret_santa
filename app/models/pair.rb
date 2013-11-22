class Pair < ActiveRecord::Base
  belongs_to :group
  belongs_to :giver, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
end
