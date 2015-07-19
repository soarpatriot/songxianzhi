# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|i| "city#{i}@qq.com"}
    sequence(:mobile_number) {|i| (1300000000 + i).to_s }
    password "12345678234"
    sequence(:name) {|i| "city-#{i}"}
  end
end
