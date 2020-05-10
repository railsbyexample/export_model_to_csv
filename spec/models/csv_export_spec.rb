require 'rails_helper'

RSpec.describe CsvExport, type: :model do
  it 'has a valid factory' do
    expect(build(:csv_export)).to be_valid
  end
end
