class Group < ActiveRecord::Base
  has_one :spreadsheet
  has_many :pairs
  has_many :users, through: :spreadsheet

  def self.create_yourself(file)
    group = Group.create
    group.spreadsheet = Spreadsheet.create(group: group)
    group.spreadsheet.add_users(file)
    group.pair_up
    group.deliver_emails
  end

  def pair_up
    @used = []
    @all_users = users.load
    users.each do |u|
      usable = users_available_for(u)
      if stymied?(usable)
        reshuffle
      else
        recipient = usable.sample
        pairs.create(giver: u, receiver: recipient)
        @used << recipient
      end
    end
  end

  def deliver_emails
    pairs.each do |p|
      GroupMailer.recipient_email(p.giver, p.receiver).deliver
    end
  end

  private

    def users_available_for(user)
      @all_users - user.verboten_people - @used
    end

    def stymied?(usable)
      pairs.count < users.count && usable.empty?
    end

    def reshuffle
      pairs.destroy_all
      pair_up
    end
end
