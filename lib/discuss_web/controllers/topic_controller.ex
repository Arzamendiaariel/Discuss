defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  use DiscussWeb, :model
  alias Discuss.{Repo, Topic}
  plug Discuss.Plugs.RequrieAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def show(conn, params) do
    %{"id" => topic_id} = params
    topic = Repo.get!(Topic, topic_id)
    render(conn, "show.html", topic: topic)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    %{"topic" => topic} = params

    changeset =
      conn.assigns[:user]
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Topic not created")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, params) do
    %{"id" => topic_id} = params
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, params) do
    %{"id" => topic_id, "topic" => topic} = params
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Unable to Update Topic")
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, params) do
    %{"id" => topic_id} = params
    Repo.get!(Topic, topic_id) |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get!(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You don't have credentials for that action")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
