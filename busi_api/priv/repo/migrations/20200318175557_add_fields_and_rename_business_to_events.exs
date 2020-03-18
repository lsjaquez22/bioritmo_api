defmodule BusiApi.Repo.Migrations.AddFieldsAndRenameBusinessToEvents do
  use Ecto.Migration

  def change do
    rename table(:businesses), to: table(:events)

    alter table(:events) do
      add :location, :string
      add :year, :integer
      add :month, :integer
      add :day, :integer
    end
  end
end
