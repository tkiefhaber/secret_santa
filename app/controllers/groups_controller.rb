class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    if params[:group] && params[:group][:file]
      Group.create_yourself(params[:group][:file])
      redirect_to new_group_path, :flash => {:notice => 'emails will go out to participants shortly'}
    else
      redirect_to new_group_path, :flash => {:warning => 'you forgot to upload a file, silly. try again.'}
    end
  end

end
