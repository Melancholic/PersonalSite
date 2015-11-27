require 'rails_helper'

describe "StaticPages" do
  subject{ page }
    describe "Home page" do
      before do
        visit root_path
      end
      it { should have_title(full_title() )}
      describe " have nav links"do
        it{should have_link("Нагорный Андрей", root_url)}
        it{should have_selector("nav#mainNav div.container-fluid div.navbar-header a.navbar-brand")}
        it{should have_link("Обо мне", about_url)}
        it{should have_link("Проекты", services_url)}
        it{should have_link("Портфолио", portfolio_url)}
        it{should have_link("Контакты", contact_url)}
        it{should have_selector("header div.header-content")}
      end
  end
  it "should have the right links on the Layout" do
    visit root_path;
    find(:linkhref, contact_url).click;
    expect(page).to have_title(full_title(''));
  end
end

