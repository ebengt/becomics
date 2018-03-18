defmodule Becomics.Repo.Migrations.ComicUniqueName do
  use Ecto.Migration

  def change do
	create unique_index(:comics, [:name])
  end
end
