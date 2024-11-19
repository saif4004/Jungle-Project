require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "Should be invalid without a password" do
      user = User.new(name: "John", email: 'test@test.COM', password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it "Should be invalid without a matching password" do
      user = User.new(name: "John", email: 'test@test.COM', password: 'oassword', password_confirmation: 'passwordd')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "Should be invalid if email is not unique" do
      user1 = User.create(name: "John", email: 'test@test.com', password: 'password', password_confirmation: 'password')
      user2 = User.new(name: "Jane", email: 'TEST@TEST.COM', password: 'password', password_confirmation: 'password')
      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end
    it "Should be invalid without an email" do 
      user = User.new(name: "John", email: nil, password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "Should be invalid without a name" do
      user = User.new(name: nil, email: 'test@test.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it "Should be invalid if password is less than 6 characters long" do
      user = User.new(name: "John", email: 'test@test.com', password: 'pass', password_confirmation: 'pass')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(name: "John", email: 'test@test.com', password: 'password', password_confirmation: 'password')
    end
    it "Should return the user if the email and password match" do
      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).to eq(@user)
    end
    it "Should return nil if the email and password do not match" do
      user = User.authenticate_with_credentials('wrre@test.com', 'assword')
      expect(user).to be_nil
    end
    it "Should return the user if the email has leading or trailing spaces" do
      user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(user).to eq(@user)
    end
    it "Should return the user if the email is in the wrong case" do
      user = User.authenticate_with_credentials('TeST@TEST.com', 'password')
      expect(user).to eq(@user)
    end
  end
end
