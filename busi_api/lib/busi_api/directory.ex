defmodule BusiApi.Directory do
  @moduledoc """
  The Directory context.
  """

  import Ecto.Query, warn: false
  alias BusiApi.Repo
  alias BusiApi.Accounts

  alias BusiApi.Directory.Business

  @doc """
  Returns the list of businesses.

  ## Examples

      iex> list_businesses()
      [%Business{}, ...]

  """
  def list_businesses do
    Repo.all(Business)
  end

  @doc """
  Gets a single business.

  Raises `Ecto.NoResultsError` if the Business does not exist.

  ## Examples

      iex> get_business!(123)
      %Business{}

      iex> get_business!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business!(id), do: Repo.get!(Business, id)

  @doc """
  Creates a business.

  ## Examples

      iex> create_business(%{field: value})
      {:ok, %Business{}}

      iex> create_business(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business(id, attrs \\ %{}) do
    {:ok, event} =
      %Business{}
      |> Business.changeset(attrs)
      |> Repo.insert()

    event = Repo.preload(event, [:users])
    user = Accounts.get_user!(id)
    event_changeset = Ecto.Changeset.change(event)
    user_event = event_changeset |> Ecto.Changeset.put_assoc(:users, [user])
    Repo.update!(user_event)
  end

  def add_business(id_user, id_event) do
    event = Repo.get!(Business, id_event)

    IO.inspect(event)

    event = Repo.preload(event, [:users])
    user = Accounts.get_user!(id_user)
    IO.inspect(user)
    event_changeset = Ecto.Changeset.change(event)
    user_event = event_changeset |> Ecto.Changeset.put_assoc(:users, [user | event.users])
    Repo.update!(user_event)
  end

  @doc """
  Updates a business.

  ## Examples

      iex> update_business(business, %{field: new_value})
      {:ok, %Business{}}

      iex> update_business(business, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business(%Business{} = business, attrs) do
    business
    |> Business.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business.

  ## Examples

      iex> delete_business(business)
      {:ok, %Business{}}

      iex> delete_business(business)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business(%Business{} = business) do
    Repo.delete(business)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business changes.

  ## Examples

      iex> change_business(business)
      %Ecto.Changeset{source: %Business{}}

  """
  def change_business(%Business{} = business) do
    Business.changeset(business, %{})
  end
end
