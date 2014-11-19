class AddVerbotenPeopleToUser < ActiveRecord::Migration
  def change
    add_column :users, :verboten_people, :string
  end
end
