require 'rails_helper'

RSpec.describe 'csv_exports/index.html.erb', type: :view do
  let!(:csv_exports) do
    3.times.map do |n|
      create :csv_export, created_at: n.days.ago
    end
  end

  before do
    assign(:csv_exports, CsvExport.all.page(1).per(2))
  end

  it "shows the csv_exports' created_at" do
    render

    csv_exports[0..1].each do |csv_export|
      expect(rendered).to match(csv_export.created_at.to_s(:long))
    end
  end

  it 'paginates the csv_exports' do
    render
    expect(rendered).not_to match(csv_exports.last.created_at.to_s(:long))
  end
end
