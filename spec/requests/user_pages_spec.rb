require 'spec_helper'

describe "User pages" do
 shared_examples_for "all user pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end
  subject { page }
it "should have the right links on the layout" do
    visit root_path
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
end
  describe "new page" do
    before { visit signup_path }
    let(:heading) { 'Sign up' } 
    let(:page_title) { 'Sign up' } 
    it_should_behave_like "all user pages"
    #it { should have_selector('h1',  text: 'Sign up') }
    #it { should have_selector('title', text: full_title('Sign up')) }
  end
end
