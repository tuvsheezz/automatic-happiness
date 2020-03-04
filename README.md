# README
***Alexandre Rousseau - "APIonRails":6***

##### Ruby version
- 2.7.0

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
