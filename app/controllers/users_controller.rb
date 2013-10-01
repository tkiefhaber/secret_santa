class UsersController < ApplicationController
  def show
    @group = Group.find(params[:id])
    @pair  = @group.pairs.where(giver_id: params[:giver_id])
    @giver = User.find(@pair.giver_id)
    @receiver = User.find(@pair.receiver_id)
  end
end
