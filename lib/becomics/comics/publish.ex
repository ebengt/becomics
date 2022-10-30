defmodule Becomics.Comics.Publish do
  @moduledoc "Publish record"
  use Ecto.Schema
  import Ecto.Changeset
  alias Becomics.Comics.Publish

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "publishes" do
    field :day, :string
    field :comic_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(%Publish{} = publish, attrs) do
    publish
    |> cast(attrs, [:day, :comic_id])
    |> validate_required([:day])
    |> Ecto.Changeset.unique_constraint(:comic_id_day)
  end
end
