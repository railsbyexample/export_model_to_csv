require 'csv'

class CsvExportJob < ApplicationJob
  queue_as :default

  def perform(csv_export)
    @csv_export = csv_export
    @users = User.all

    csv_export.file.attach \
      io: StringIO.new(csv_content),
      filename: filename

    csv_export.finish!
  end

  private

  attr_reader :csv_export, :users

  def filename
    "#{csv_export.created_at.strftime('%Y-%m-%d')}-users.csv"
  end

  COLUMNS = %w[id name email].freeze

  def csv_content
    CSV.generate(headers: true) do |csv|
      csv << COLUMNS
      users.each { |user| csv << user.attributes.slice(*COLUMNS) }
    end
  end
end
