require 'spec_helper'

describe User do

  subject(:user) {  User.new( username: "seanwooj", first_name: "Sean",
                              last_name: "Kim", email: "seanwoojinkim@gmail.com",
                              password: "12345678", password_confirmation: "12345678" ) }

  it { should respond_to(:username) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  # AUTHENTICATION SPECS

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by_email(user.email) }

    describe "with a valid password" do
      it { should == found_user.authenticate(user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("notreals") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  # PASSWORD SPECS

  describe "when password is not present" do
    before { user.password = user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when password confirmation is mismatched" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  # FIRST NAME SPECS

  describe "when first name is not present" do
    before { user.first_name = " " }
    it { should_not be_valid }
  end

  describe "when first_name is too long" do
    before { user.first_name = "g" * 31 }
    it { should_not be_valid }
  end

  # LAST NAME SPECS

  describe "when last name is not present" do
    before { user.last_name = " " }
    it { should_not be_valid }
  end

  describe "when last_name is too long" do
    before { user.last_name = "g" * 31 }
    it { should_not be_valid }
  end

  # EMAIL SPECS

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org examplle.ue@foo. foo@fo_fo.com foo@foo+foo.com]
      addresses.each do |address|
        user.email = address
        user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be invalid" do
      addresses = %w[user@foo.com A_SSE-ee@f.ss.org examplle.ue@foo.jp foo_fo@foo.com foo+foo@ffoo.com]
      addresses.each do |address|
        user.email = address
        user.should be_valid
      end
    end
  end

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when email is not unique" do
    before do
      user_with_same = user.dup
      user_with_same.email = user.email.upcase
      user_with_same.save
      user.username = "somethingdifferent"
    end

    it { should_not be_valid }
  end

  # USERNAME SPECS

  describe "when username is not present" do
    before { user.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { user.username = "g" * 31 }
    it { should_not be_valid }
  end

  describe "when username is not unique" do
    before do
      user_with_same = user.dup
      user_with_same.username = user.username.upcase
      user_with_same.save
      user.email = "somethingdifferent@different.org"
    end

    it { should_not be_valid }
  end


end
