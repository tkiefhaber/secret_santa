class User < ActiveRecord::Base
  belongs_to :spreadsheet

  def verboten_people
    [self]
  end
end
