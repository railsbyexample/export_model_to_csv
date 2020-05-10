class CsvExportsController < ApplicationController
  def create
    CsvExport.create!
    redirect_to csv_exports_url
  end

  def index
    @csv_exports = CsvExport.all.order(created_at: :desc).page(params[:page])
  end

  def show
    csv_export = CsvExport.find(params[:id])
    render json: {
      finished: csv_export.finished?,
      download_url: (url_for(csv_export.file) if csv_export.file.attached?)
    }.compact, status: :ok
  end
end
