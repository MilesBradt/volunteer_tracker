require "capybara/rspec"
require "./app"
require "pry"
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# Your project should be set up so that a volunteer can only be created if a project already exists. (This makes it easier to assign the one to many relationship in Sinatra.) Focus on getting one integration spec passing at a time.

# The user should be able to visit the home page and fill out a form to add a new project. When that project is created, the application should direct them back to the homepage.

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    fill_in('title', :with => 'Teaching Kids to Code')
    click_button('Create Project')
    expect(page).to have_content('Teaching Kids to Code')
  end
end

# A user should be able to click on a project to see its detail. The detail page includes a form where the project can be updated. When the form is submitted, the user can be directed to either the home page or that project's detail page. (The test will work for either.)

describe 'the project update path', {:type => :feature} do
  it 'allows a user to change the name of the project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    # click_link('Edit Project')
    fill_in('edit', :with => 'Teaching Ruby to Kids')
    click_button('Edit Project')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end
