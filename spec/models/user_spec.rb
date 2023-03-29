require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    # validation tests/examples here

    before(:each) do
      @user = User.new(
        first_name: 'GeeAr',
        last_name: 'Maysa',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
    end

    context 'User' do 
      it 'valid first_name, last_name, email and passwords when filled' do
        @user.save

        expect(@user.errors.full_messages).to be_empty
      end
    end

    context 'Password' do
      it 'not valid when password is blank' do
        @user.password = nil
        @user.save

        expect(@user.errors.full_messages).not_to be_empty
      end

      it 'not valid when password confirmation is blank' do
        @user.password_confirmation = nil
        @user.save

        expect(@user.errors.full_messages).not_to be_empty
      end

      it 'not valid when password do not match' do
        @user.password_confirmation = 'password-mismatch'
        @user.save
        
        expect(@user.errors.full_messages).not_to be_empty
      end

      it 'not valid when password length is less than 6' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.save

        expect(@user.errors.full_messages).not_to be_empty
      end
    end

    context 'Email' do
      it 'email is unique and case insensitive' do
        @user.save
        
        @same_email_user = User.create(
        first_name: 'jayr',
        last_name: 'Me-sa',
        email: 'TEST@TEST.com',
        password: '12345678',
        password_confirmation: '12345678'
        )
        
        expect(@same_email_user.errors.full_messages).not_to be_empty
      end
      
      it 'not valid when email is blank' do
        @user.email = nil
        @user.save
        
        expect(@user.errors.full_messages).not_to be_empty
      end
    end

    context 'Name' do
      it 'not valid when first name is blank' do
        @user.first_name = nil
        @user.save
        
        expect(@user.errors.full_messages).not_to be_empty
      end

      it 'not valid when last name is blank' do
        @user.last_name = nil
        @user.save
        
        expect(@user.errors.full_messages).not_to be_empty
      end
    end
    
    after(:each) do
      @user.destroy unless @user.nil?
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        first_name: 'GeeAr',
        last_name: 'Maysa',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
    end

    it 'fails if stored password does not equal the password provided' do
      @user = User.authenticate_with_credentials('test@test.com', '123456')

      expect(@user).to be_falsey
    end

    it 'valid if stored password matches password' do
      @user = User.authenticate_with_credentials('test@test.com', '12345678')

      expect(@user).to be_truthy
    end

    it 'valid if email has extra spaces and password is correct' do
      @user = User.authenticate_with_credentials(' test@test.com ', '12345678')
      
      expect(@user).to be_truthy
    end
      
    it 'valid if email has mismatch case and password is correct' do
      @user = User.authenticate_with_credentials('TeSt@TeSt.com', '12345678')
      
      expect(@user).to be_truthy
    end

    it 'fails if email is invalid and password is correct' do
      @user = User.authenticate_with_credentials('test123@test.com', '12345678')
      
      expect(@user).to be_nil
    end

 end
end

