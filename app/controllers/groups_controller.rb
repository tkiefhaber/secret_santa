class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    Group.create_yourself(params[:group][:file])
    redirect_to new_group_path, :flash => {:notice => 'emails will go out to participants shortly'}
  end
end
