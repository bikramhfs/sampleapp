require 'spec_helper'

describe "Static pages" do
  subject{page}
  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end
  
  #let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
    before{visit root_path}
    let(:heading) {'Sample App'  } 
    let(:page_title) { '' } 
    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end
    #it{should have_selector('h1', text: 'Sample App')}
    #it{should have_selector('title', text: full_title(''))}
     #it{ should_not have_selector 'title', text: '| home' }

  

   describe "Help page" do
    before{visit help_path}
    let(:heading) {'Help'}
    let(:page_title) { 'Help' } 
    it_should_behave_like "all static pages"
#it{ should_not have_selector 'title', text: '|help'}
   #it{should have_selector('h1', text: 'Help')}
  #  it{should have_selector('title',text: full_title('Help'))}
  end


describe "About page" do
  before{visit about_path}
  let(:heading) { 'About Us' } 
  let(:page_title) { 'About Us' } 
  it_should_behave_like "all static pages"
    #it{ should_not have_selector 'title', text: '|about'}
   # it{should have_selector('h1', text: 'About Us')}
    #it{should have_selector('title', text: full_title('About Us'))}

  end
  describe "Contact page" do
    before{visit contact_path}
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }
    it_should_behave_like "all static pages"
#it(should_not have_selector 'title', text: '|contact')  
   #it{should have_selector('h1', text: 'Contact')}
    #it{should have_selector('title',text: full_title('Contact'))}

  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    
  end
end

