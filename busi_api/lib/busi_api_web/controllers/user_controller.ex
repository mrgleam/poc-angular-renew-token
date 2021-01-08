defmodule BusiApiWeb.UserController do
  use BusiApiWeb, :controller

  alias BusiApi.Accounts
  alias BusiApi.Accounts.User
  alias BusiApiWeb.Auth.Guardian

  action_fallback BusiApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user),
    {:ok, refresh_token, _claims} <- Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {30, :minute}) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token, refresh_token: refresh_token})
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password),
    {:ok, refresh_token, _claims} <- Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {30, :minute}) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token, refresh_token: refresh_token})
    end
  end

  def renew(conn, %{"token" => token}) do
    with {:ok, _old_stuff, {new_token, _new_claims}} <- Guardian.exchange(token, "refresh", "access") do
      conn
      |> put_status(:created)
      |> render("token.json", %{token: new_token})
    end
  end
end
