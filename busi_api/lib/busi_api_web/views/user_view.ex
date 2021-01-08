defmodule BusiApiWeb.UserView do
  use BusiApiWeb, :view
  alias BusiApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token, refresh_token: refresh_token}) do
    %{email: user.email,
      token: token,
      refresh_token: refresh_token
    }
  end

  def render("token.json", %{token: token}) do
    %{ token: token }
  end
end
