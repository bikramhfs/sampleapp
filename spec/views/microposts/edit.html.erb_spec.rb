require 'spec_helper'

describe "microposts/edit" do
  before(:each) do
    @micropost = assign(:micropost, stub_model(Micropost,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit micropost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => microposts_path(@micropost), :method => "post" do
      assert_select "input#micropost_name", :name => "micropost[name]"
      assert_select "input#micropost_description", :name => "micropost[description]"
    end
  end
end
