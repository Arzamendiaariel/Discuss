defmodule Discuss.Topic do
  use DiscussWeb, :model
  alias Discuss.{Repo, Topic}
  alias Discuss.Topic

  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    Repo.insert(changeset)
  end
end
