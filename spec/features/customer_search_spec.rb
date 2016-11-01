require "rails_helper"

feature "Customer Search" do
  let(:email) { "bob@example.com" }
  let(:password) { "password1234" }

  before do
    User.create!(email: email, password: password)

    create_customer(first_name: "Robert", last_name: "Aaron")
    create_customer(first_name: "Bob", last_name: "Johnson")
    create_customer(first_name: "JR", last_name: "Bob")
    create_customer(first_name: "Bobby", last_name: "Dobbs")
    create_customer(first_name: "Bob", last_name: "Jones",
                    email: "bob123@somewhere.com")

    visit "/customers"
    fill_in      "Email",    with: "bob@example.com"
    fill_in      "Password", with: "password1234"
    click_button "Log in"
  end

  scenario "Search by Name" do
    within "section.search-form" do
      fill_in "keywords", with: "bob"
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(4)

      expect(page.all("ol li.list-group-item")[0]).to have_content("JR")
      expect(page.all("ol li.list-group-item")[0]).to have_content("Bob")

      expect(page.all("ol li.list-group-item")[3]).to have_content("Bob")
      expect(page.all("ol li.list-group-item")[3]).to have_content("Jones")
    end
  end

  scenario "Search by Email" do
    within "section.search-form" do
      fill_in "keywords", with: "bob123@somewhere.com"
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(4)

      expect(page.all("ol li.list-group-item")[0]).to have_content("Bob")
      expect(page.all("ol li.list-group-item")[0]).to have_content("Jones")

      expect(page.all("ol li.list-group-item")[1]).to have_content("JR")
      expect(page.all("ol li.list-group-item")[1]).to have_content("Bob")

      expect(page.all("ol li.list-group-item")[3]).to have_content("Bob")
      expect(page.all("ol li.list-group-item")[3]).to have_content("Johnson")
    end
  end
end

def create_customer(first_name: nil, last_name: nil, email: nil)
  first_name ||= FFaker::Name.first_name
  last_name  ||= FFaker::Name.last_name
  email      ||= FFaker::Internet.user_name + rand(1000).to_s + "@" +
                  FFaker::Internet.domain_name
  Customer.create!(
    first_name:  first_name,
    last_name:   last_name,
    username:    FFaker::Internet.user_name + rand(100).to_s,
    email:       email
  )
end