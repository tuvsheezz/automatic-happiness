# README
***Alexandre Rousseau - "APIonRails":6***

##### Ruby version
- 2.6.5

##### Rails version
- 6.0.2.1

##### Database
- Sqlite3

---

#### Setting the API & Api versioning
```sh
  rails new <project_name> --api
  cd <project_name>
  mkdir app/controllers/api
  mkdir app/controllers/api/v1
```

 Add namespaces to config/routes.rb

```sh
namespace :api, defaults: { format: :json } do
  namespace :v1 do
    #v1 routes goes here...
  end
end
```

#### Presenting users
##### migration

```sh
# create user model
rails generate model User email:string password_digest:string
```

edit migration file
```
  create_table :users do |t|
    t.string :email, null: false
    t.index :email, unique: true
    t.string :password_digest, null: false
    t.timestamps
  end
```
```
rake db:migrate
```
check schema.rb, rake db:migrate:status and db

##### model
Add validations
```
validates :email, uniqueness: true
validates_format_of :email, with: /@/
validates :password_digest, presence: true
```

##### Unit tests

```
#gemfile add faker to development group
gem 'faker', '~> 2.10', '>= 2.10.2'
```
```sh
bundle install

```
add next 3 tests to test/models/user_test.rb
```sh
test 'user with a valid email should be valid' do
  user = User.new email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
  assert user.valid?
end

test 'user with invalid email should be invalid' do
  user = User.new email: Faker::Alphanumeric.alphanumeric(number: 10), password_digest: nil
  assert_not user.valid?
end

test 'user with taken email should be invalid' do
  other_user = User.new email: Faker::Alphanumeric.alphanumeric(number: 10), password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
  user = User.new email: other_user.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
  assert_not user.valid?
end
```

then test it
```sh
rake test
```

##### Password hash

Uncomment "gem 'bcrypt', '~> 3.1.7'" in Gemfile or run
```sh
bundle add bcrypt
```

Add next to user.rb (model)
```
class User < ApplicationRecord

  has_secure_password

  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true
end
```

Test it with rails console.
```
togi@togi market_place_api % rails c
Running via Spring preloader in process 25432
Loading development environment (Rails 6.0.2.1)
irb(main):001:0> Faker
=> Faker
irb(main):002:0> User.create! email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number:10)
   (0.4ms)  SELECT sqlite_version(*)
   (0.1ms)  begin transaction
  User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = ? LIMIT ?  [["email", "jackson_stiedemann@aufderhar.org"], ["LIMIT", 1]]
  User Create (0.5ms)  INSERT INTO "users" ("email", "password_digest", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["email", "jackson_stiedemann@aufderhar.org"], ["password_digest", "2j0b0v25yg"], ["created_at", "2020-03-04 06:51:17.770376"], ["updated_at", "2020-03-04 06:51:17.770376"]]
   (5.9ms)  commit transaction
=> #<User id: 1, email: "jackson_stiedemann@aufderhar.org", password_digest: [FILTERED], created_at: "2020-03-04 06:51:17", updated_at: "2020-03-04 06:51:17">
irb(main):003:0> User.create! email: Faker::Internet.email, password: Faker::Alphanumeric.alphanumeric(number:10), password_confirmation: Faker::Alphanumeric.alphanumeric(number:10)
   (0.1ms)  begin transaction
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = ? LIMIT ?  [["email", "agnes@wehner.com"], ["LIMIT", 1]]
   (0.0ms)  rollback transaction
Traceback (most recent call last):
        1: from (irb):2
ActiveRecord::RecordInvalid (Validation failed: Password confirmation doesn't match Password)
```
