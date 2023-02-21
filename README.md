# テーブル設計

## Users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association
- has_many :items
- has_many :orders

## Items テーブル

| Column      | Type       | Options                        | 
| ----------- | ---------- | ------------------------------ |
| product     | text       | null: false                    |
| content     | text       | null: false                    |
| category    | string     | null: false                    |
| status      | string     | null: false                    |
| charge      | string     | null: false                    |
| prefecture  | string     | null: false                    |
| preparation | string     | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## Orders テーブル

| Column | Type       | Options                        | 
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliverys テーブル

| Column     | Type       | Options                        | 
| ---------- | ---------- | ------------------------------ |
| postcode   | string     | null: false                    |
| prefecture | string     | null: false                    |
| city       | string     | null: false                    |
| block      | string     | null: false                    |
| building   | string     |                                |
| phone      | string     | null: false                    |
| order      | references | null: false, foreign_key: true |

### Association
- belongs_to :order