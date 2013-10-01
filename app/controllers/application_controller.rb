class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv"   then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls"   then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx"  then Roo::Excelx.new(file.path, nil, :ignore)
    else
      raise "Unknown file type: #{file.original_filename}"
    end
  end

  def random_password
    #do random password here
  end
end
