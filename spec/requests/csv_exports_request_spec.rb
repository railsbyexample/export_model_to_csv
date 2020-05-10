require 'rails_helper'

RSpec.describe 'CsvExports', type: :request do
  describe 'POST /csv_exports' do
    it 'returns http success' do
      post '/csv_exports'
      expect(response).to redirect_to(csv_exports_url)
    end

    it 'creates a new `CsvExport`' do
      expect do
        post '/csv_exports'
      end.to change(CsvExport, :count).by(1)
    end
  end

  describe 'GET /csv_exports' do
    it 'returns http success' do
      get '/csv_exports'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /csv_exports/:id' do
    let(:csv_export) { create :csv_export }

    it 'returns http success' do
      get "/csv_exports/#{csv_export.to_param}"
      expect(response).to have_http_status(:success)
    end

    it 'returns a json response with the export status' do
      get "/csv_exports/#{csv_export.to_param}"
      expect(JSON.parse(response.body))
        .to eq({ finished: csv_export.finished? }.as_json)
    end
  end
end
