require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :username => "Username",
      :nickname => "Nickname",
      :provider => "Provider",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Nickname/)
    expect(rendered).to match(/Provider/)
    expect(rendered).to match(/Url/)
  end
end
