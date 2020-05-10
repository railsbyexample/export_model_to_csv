require 'rails_helper'

RSpec.feature 'ExportUsersToCsv', type: :feature do
  let!(:users) { create_list :user, 3 }

  it 'starts a csv export' do
    visit users_url

    click_on 'Export all users to CSV'

    expect(page).to have_content(CsvExport.last.created_at.to_s(:long))
  end

  it 'creates a download link for the exported file' do
    visit users_url

    perform_enqueued_jobs do
      click_on 'Export all users to CSV'
    end

    click_on 'Download'

    users.each do |user|
      expect(page).to have_content(user.email)
    end
  end
end
