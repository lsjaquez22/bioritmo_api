defmodule BusiApi.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :user_name, :string
      add :year, :integer
      add :month, :integer
      add :day, :integer
    end
  end
end
