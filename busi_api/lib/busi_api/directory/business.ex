defmodule BusiApi.Directory.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :name, :string
    field :tag, :string
    field :location, :string
    field :year, :integer
    field :month, :integer
    field :day, :integer
    many_to_many :users, BusiApi.Accounts.User, join_through: "users_events"

    timestamps()
  end

  @doc false
  def changeset(events, attrs) do
    events
    |> cast(attrs, [:name, :description, :tag, :location, :year, :month, :day])
    |> validate_required([:name, :description, :tag, :location, :year, :month, :day])
  end
end
