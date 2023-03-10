defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  alias Discuss.{Repo, User}
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: provider
    }

    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    # |> put_session(:user_id, nil)
    |> configure_session(drop: true)
    |> put_flash(:info, "Succesfully sing out")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, reasons} ->
        IO.inspect(reasons)

        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
