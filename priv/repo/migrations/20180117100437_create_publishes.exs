defmodule Becomics.Repo.Migrations.CreatePublishes do
  use Ecto.Migration

  def change do
    create table(:publishes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :day, :string
      add :comic_id, references(:comics, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:publishes, [:comic_id])
  end
end
