defmodule Becomics.Repo.Migrations.PublishUnique do
  use Ecto.Migration

  def change do
    create unique_index(:publishes, [:comic_id, :day])
  end
end
