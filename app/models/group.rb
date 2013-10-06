class Group < ActiveRecord::Base
  has_many :users
  has_many :pairs

  def self.create_yourself(spreadsheet)
    group = Group.create
    add_users(group, open_spreadsheet(spreadsheet))
    group.pair_up
    group.deliver_emails
  end

  def self.add_users(group, spreadsheet)
    uploaded_users = []
    row_count = spreadsheet.column(1).count
    (2..row_count).each do |row|
      uploaded_users << spreadsheet.row(row)
    end
    uploaded_users.each do |u|
      group.users.create(
        first_name: u[0],
         last_name: u[1],
             email: u[2],
      )
    end
  end

  def pair_up
    used = []
    users.each do |u|
      usable = users.to_a - [u] - used
      recipient = usable.sample
      pairs.create(:giver_id => u.id, :receiver_id => recipient.id)
      used << recipient
    end
  end

  def deliver_emails
    pairs.each do |p|
      giver = User.find(p.giver_id)
      GroupMailer.recipient_email(giver).deliver
    end
  end

  private

    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv"   then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls"   then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx"  then Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
      end
    end

end
