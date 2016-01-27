require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :username => "Username",
        :nickname => "Nickname",
        :provider => "Provider",
        :url => "Url"
      ),
      User.create!(
        :username => "Username",
        :nickname => "Nickname",
        :provider => "Provider",
        :url => "Url"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => "Provider".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
