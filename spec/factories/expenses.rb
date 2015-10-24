FactoryGirl.define do
  factory :expense do
    name "Tea"
    cost 10
    date Date.today
    user
  end
end
