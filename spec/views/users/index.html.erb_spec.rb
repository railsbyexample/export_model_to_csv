require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :view do
  let!(:users) { create_list :user, 3 }

  before do
    assign(:users, User.all.page(1).per(2))
  end

  it "shows the users' emails" do
    render

    users[0..1].each do |user|
      expect(rendered).to match(user.email)
    end
  end

  it 'paginates the users' do
    render
    expect(rendered).not_to match(users.last.email)
  end
end
