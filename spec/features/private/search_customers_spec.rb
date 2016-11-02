require 'rails_helper'

feature "customers search" do
  include SignUpAndLogin

  scenario "see the search form and sample results" do
    sign_up_and_log_in
    2.times do |i|
      Customer.create!(
        first_name:    "Robert",
         last_name:    Faker::Name.last_name,
          username: "#{Faker::Internet.user_name}#{i}",
             email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}")
    end
    2.times do |i|
      Customer.create!(
        first_name: "bob",
         last_name: "McJones",
          username: "#{Faker::Internet.user_name}#{i}",
             email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}")
    end
    Customer.create!(
      first_name:    Faker::Name.first_name,
       last_name: "bobby",
        username: "#{Faker::Internet.user_name}5",
           email: "#{Faker::Internet.user_name}5@#{Faker::Internet.domain_name}")
    Customer.create!(
      first_name: "robert",
       last_name: "Jones",
        username: "bobby_#{Faker::Internet.user_name}",
           email: "bob123@somewhere.net")
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")

    within "section.search-form" do
      expect(page).to have_selector("input[name='keywords']")
      fill_in "keywords", with: "bob"
    end
    expect(page).to have_selector("aside.loading-progress .not-loading")

    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(3)
      expect(page).to have_content("Bob")
      expect(page).not_to have_content("bob")
      expect(page).to have_content("McJones")
      expect(page).not_to have_content("Mcjones")
      screenshot! filename: "customer-search-bob.png"
    end
    
    fill_in "keywords", with: "bobby"
    expect(page).to have_selector("aside.loading-progress .not-loading")

    within "section.search-results" do
      expect(page.all("ol li.list-group-item").count).to eq(1)
      screenshot! filename: "customer-search-bobby.png"
    end
  end
end