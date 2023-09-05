

![alt text](https://github.com/hashFigs/canvasy/tree/main/assets/png/canvasify-logo.png?raw=true)





```sh
mix phx.new canvas_app
```

```sh
mix phx.gen.context Places Location locations street:string num:string zip:string city:string latitude:float longitude:float
```

```sh
mix phx.gen.context Members User users name:string surname:string
```


from the console: 

CanvasApp.Members.create_user(user_attr)

alias CanvasApp.Members
alias CanvasApp.Places
alias CanvasApp.Ecto
alias CanvasApp.Repo
alias CanvasApp.Members.User
alias CanvasApp.Places.Location



location_params =  %{street: "123 Main St", num: "42", city: "Exampleville", zip: "12345", latitude: "30.44", longitude: "55.67"}
location =%Location{} |> Location.changeset(location_params) |> Repo.insert()


user_params = %{name: "yaehh1", surname: "holaa"}
#user =%User{} |> User.changeset(user_params) |> Repo.insert()
user = %User{} |> User.changeset(user_params) |> Ecto.changeset.put_assoc(:location, location) |> Repo.insert()




# lib/canvas_app/location.ex
schema "locations" do
  field :street, :string
  field :num, :string
  field :zip, :string
  field :city, :string
  field :latitude, :float
  field :longitude, :float
  has_many :users, CanvasApp.User
end

# lib/canvas_app/user.ex
schema "users" do
  field :name, :string
  field :surname, :string
  belongs_to :location, CanvasApp.Location
end