FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 2)}
    email {Faker::Internet.free_email}
    password {Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    last_name {'山田'}
    first_name {'メアリーじゅん'}
    last_name_kana {'ヤマダ'}
    first_name_kana {'メアリージュン'}
    birthday {Faker::Date.in_date_period}
  end
end