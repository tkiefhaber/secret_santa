class User < ActiveRecord::Base
  belongs_to :spreadsheet

  def forbidden_people
    User.where(email: verboten_people.split(',').strip)
  end

end
