require 'rails_helper'

RSpec.describe CsvExportJob, type: :job do
  let(:csv_export) { create :csv_export }

  it 'attaches the exported file to the given record' do
    described_class.perform_now(csv_export)
    expect(csv_export.file.attached?).to be(true)
  end

  it "sets the record's status to exported" do
    described_class.perform_now(csv_export)
    expect(csv_export.reload.finished?).to be(true)
  end

  it 'includes the contact data in the exported file' do
    contacts = 3.times.map do |n|
      create :user,
             name: "User #{n + 1}",
             email: "email-#{n + 1}@example.com"
    end

    described_class.perform_now(csv_export)
    file_content = csv_export.file.download

    contacts.each do |contact|
      expect(file_content).to include(contact.email, contact.name)
    end
  end
end
