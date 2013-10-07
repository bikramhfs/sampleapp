# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'spec_helper'

describe User do
 before do
  @user = User.new(name: "Example User", email: "user@example.com",
   password: "foobar", password_confirmation: "foobar")
end

subject { @user }

it { should respond_to(:name) }
it { should respond_to(:email) }
it { should respond_to(:password_digest) }
it { should respond_to(:password) }
it { should respond_to(:password_confirmation) }
it { should respond_to(:remember_token) }
it { should respond_to(:admin) }
it { should respond_to(:authenticate) }
it { should be_valid }
it { should_not be_admin }
describe "with admin attribute set to 'true'" do  
  before do
  @user.save!
  @user.toggle!(:admin)
  end
  it { should be_admin }
end


describe "when name is not present" do
  before { @user.name = " " }
  it { should_not be_valid }
end

describe "when email is not present" do
  before { @user.email = " " }
  it { should_not be_valid }
end
  #Name validation
  describe "when name is too long" do
    before{ @user.name = "a"*51}
    it{ should_not be_valid}  
  end
  describe " when email is too long" do
    before{ @user.email = "a"*45}
    it{ should_not be_valid}
  end 
# Email is format validation 
describe "when email is invalid" do 
  it "should be invalid" do 
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
     foo@bar_baz.com foo@bar+baz.com]
     addresses.each do |invalid_address|
      @user.email = invalid_address
      @user.should_not be_valid
    end
  end
end
describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by_email(@user.email) }

end

describe "when email is valid" do 
  it "should be valid" do 
    addresses =  %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      @user.email = valid_address
      @user.should be_valid
    end
  end
end
# for uniqueness of email id 
describe "when email address is already taken" do
  before do
    user_with_same_email = @user.dup
    user_with_same_email.email = @user.email.upcase
    user_with_same_email.save
  end

  it { should_not be_valid }
end

  #password validation
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
#password authenticate
describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by_email(@user.email) }
end
#if password do not match

describe "when password doesn't match confirmation" do
  before { @user.password_confirmation = "mismatch" }
  it { should_not be_valid }
end
#if password confirmation is nill

describe "when password confirmation is nil" do
  before { @user.password_confirmation = nil }
  it { should_not be_valid }
end
#for too short password
describe "with a password that's too short" do
  before { @user.password = @user.password_confirmation = "a" * 5 }
  it { should be_invalid }
end
describe "email with mixed case" do
  let(:mixed_case_email) { "Foo@ExAMPle.CoM" } 
  it "should save as lower case"do
  @user.email = mixed_case_email
  @user.save
  @user.reload.email.should == mixed_case_email.downcase
end
end
describe "remember token" do
  before { @user.save }
  its(:remember_token) { should_not be_blank }
end
end