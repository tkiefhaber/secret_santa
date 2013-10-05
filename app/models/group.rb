class Group < ActiveRecord::Base
  has_many :users
  has_many :pairs

  def self.create_yourself(spreadsheet)
    group = Group.create
    add_users(group, spreadsheet)
    group.pair_up
  end

  def self.add_users(group, spreadsheet)
    spreadsheet = spreadsheet.open.read
    uploaded_users = spreadsheet.split('\n')
    uploaded_users.each do |u|
      splits = u.split(',')
      group.users.create(
        first_name: splits[0],
         last_name: splits[1],
             email: splits[2],
      )
    end
  end

  private

    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv"   then Roo::Csv.new(file.path, nil)
      when ".xls"   then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx"  then Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
      end
    end

end
