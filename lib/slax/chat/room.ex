defmodule Slax.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Slax.Accounts.User
  alias Slax.Chat.Message
  alias Slax.Chat.RoomMembership

  schema "rooms" do
    field :name, :string
    field :topic, :string

    many_to_many :members, User, join_through: RoomMembership

    has_many :messages, Message

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :topic])
    |> validate_required(:name)
    |> validate_length(:name, max: 80)
    |> validate_format(:name, ~r/\A[a-z0-9-]+\z/,
      message: "can only contain lowercase letters, numbers, and dashes"
    )
    |> validate_length(:topic, max: 200)
    |> unsafe_validate_unique(:name, Slax.Repo)
    |> unique_constraint(:name)
  end
end
