defmodule BusiApi.Repo.Migrations.CreateUsersEvents do
  use Ecto.Migration

  def change do
    create table(:users_events) do
      add :event_id, references(:events)
      add :user_id, references(:users)
    end

    create unique_index(:users_events, [:event_id, :user_id])
  end
end
