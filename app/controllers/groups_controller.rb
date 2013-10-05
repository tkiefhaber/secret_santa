class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    Group.create_yourself(params[:group][:file])
    flash[:notice] = 'emails will go out to participants shortly'
    redirect_to :new
  end
end
