defmodule BusiApi.Repo.Migrations.AddBelongToInEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :owner, :integer
    end
  end
end
