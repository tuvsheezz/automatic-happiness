Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #v1 routes goes here...
    end
  end
end
