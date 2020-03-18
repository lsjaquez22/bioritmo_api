defmodule BusiApi.Repo.Migrations.ChangeNameColumnsUserEvents do
  use Ecto.Migration

  def change do
    rename table(:users_events), :event_id, to: :business_id
  end
end
