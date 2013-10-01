class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.create
    spreadsheet = open_spreadsheet(params[:file])
    uploaded_users = spreadsheet.split('\n')
    uploaded_users.each do |u|
      splits = u.split(',')
      @group.users.create(
        first_name: splits[0],
         last_name: splits[1],
             email: splits[2],
          password: random_password
      )

    end
  end
end
