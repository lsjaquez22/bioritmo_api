defmodule BusiApiWeb.BusinessController do
  use BusiApiWeb, :controller

  alias BusiApi.Directory
  alias BusiApi.Directory.Business

  action_fallback BusiApiWeb.FallbackController

  def index(conn, _params) do
    businesses = Directory.list_businesses()
    render(conn, "index.json", businesses: businesses)
  end

  def owner_events(conn, %{"id" => id}) do
    businesses = Directory.list_my_businesses(id)
    render(conn, "index.json", businesses: businesses)
  end

  def create(conn, %{"id" => id, "business" => business_params}) do
    business = Directory.create_business(id, business_params)
    render(conn, "show.json", business: business)
  end

  def add(conn, %{"id_user" => id_user, "id_event" => id_event}) do
    business = Directory.add_business(id_user, id_event)
    send_resp(conn, :no_content, "")
  end

  def remove_in_user(conn, %{"id_user" => id_user, "id_event" => id_event}) do
    business = Directory.remove_business(id_user, id_event)
    send_resp(conn, :no_content, "")
  end

  def show(conn, %{"id" => id}) do
    business = Directory.get_business!(id)
    render(conn, "show.json", business: business)
  end

  def update(conn, %{"id" => id, "business" => business_params}) do
    business = Directory.get_business!(id)

    with {:ok, %Business{} = business} <- Directory.update_business(business, business_params) do
      render(conn, "show.json", business: business)
    end
  end

  def delete(conn, %{"id" => id}) do
    business = Directory.get_business!(id)

    with {:ok, %Business{}} <- Directory.delete_business(business) do
      send_resp(conn, :no_content, "")
    end
  end
end
