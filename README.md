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
