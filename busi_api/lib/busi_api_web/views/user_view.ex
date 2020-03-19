defmodule BusiApiWeb.UserView do
  use BusiApiWeb, :view
  alias BusiApiWeb.UserView

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      user_name: user.user_name,
      year: user.year,
      month: user.month,
      day: user.day,
      token: token
    }
  end

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      user_name: user.user_name,
      year: user.year,
      month: user.month,
      day: user.day,
      events: user.events
    }
  end

  def render("userOut.json", %{users: user}) do
    %{
      users: user
    }
  end
end
