Rails.application.routes.draw do
  get "profiles/show"
  get "sessions/create"
  get "up" => "rails/health#show", as: :rails_health_check

  scope "/" do
    post "login", to: "sessions#create"
  end

  get "/profiles", to: "profiles#index"
  scope :profiles do
    get ":username", to: "profiles#show"
  end

  # USERS
  # localhost:3000/users
  get "/users", to: "users#index" # get all users
  post "/users", to: "users#create" # create a new user
  # localhost:3000/users/id
  get "/users/:id", to: "users#show" # get a single user
  put "/users/:id", to: "users#update" # update a user
  delete "users/:id", to: "users#delete" # delete a user

  get "/users/:id/posts", to: "users#posts_index" # get a user's posts

  # POSTS
  # localhost:3000/posts
  get "/posts", to: "posts#index" # get all posts
  post "/posts", to: "posts#create" # create a new post
  # localhost:3000/posts/id
  get "/posts/:id", to: "posts#show" # get a single post
  put "/posts/:id", to: "posts#update" # update a post
  delete "posts/:id", to: "posts#delete" # delete a post
  # EVENTS
  # localhost:3000/events
  get "/events", to: "events#index" # get all posts
  post "/events", to: "events#create" # create a new post
  # localhost:3000/posts/id
  get "/events/:id", to: "events#show" # get a single post
  put "/events/:id", to: "events#update" # update a post
  delete "events/:id", to: "events#delete" # delete a post
end
