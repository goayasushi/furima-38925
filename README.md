# テーブル設計

## Users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association
- has_many :items
- has_many :orders

## Items テーブル

| Column         | Type       | Options                        | 
| -------------- | ---------- | ------------------------------ |
| product        | string     | null: false                    |
| content        | text       | null: false                    |
| category_id    | integer    | null: false                    |
| status_id      | integer    | null: false                    |
| charge_id      | integer    | null: false                    |
| prefecture_id  | integer    | null: false                    |
| preparation_id | integer    | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order
- belongs_to :category
- belongs_to :status
- belongs_to :charge
- belongs_to :prefecture
- belongs_to :preparation

## Orders テーブル

| Column | Type       | Options                        | 
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliveries テーブル

| Column        | Type       | Options                        | 
| ------------- | ---------- | ------------------------------ |
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone         | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association
- belongs_to :order
- belongs_to :prefecture