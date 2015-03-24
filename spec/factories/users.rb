# This will guess the User class
FactoryGirl.define do
  factory :user do
    name "John"
    email "john@example.com"
    login "john"
    password "123"
  end
end