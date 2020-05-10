class CsvExport < ApplicationRecord
  has_one_attached :file

  def finish!
    update!(finished: true)
  end
end
