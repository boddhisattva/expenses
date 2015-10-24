FactoryGirl.define do
  factory :expense do
    name "Tea"
    cost 10
    date Time.zone.today
    user
  end
end
