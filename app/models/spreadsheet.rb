class Spreadsheet < ActiveRecord::Base
  belongs_to :group
  has_many :users

  def add_users(file)
    @spreadsheet = _parse_file(file)
    uploaded_users = []
    row_count = @spreadsheet.column(1).count
    (2..row_count).each do |row|
      uploaded_users << @spreadsheet.row(row)
    end
    uploaded_users.each do |u|
      users.create(
            first_name: u[0],
             last_name: u[1],
                 email: u[2],
       verboten_people: [u[2], u[3]].join(',')
      )
    end
  end

  private

  def _parse_file(file)
    case File.extname(file.original_filename)
    when ".csv"   then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls"   then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx"  then Roo::Excelx.new(file.path, nil, :ignore)
    else
      raise "Unknown file type: #{file.original_filename}"
    end
  end

end
