defmodule Becomics.Comic do
  @moduledoc "Comic record"
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comics" do
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Becomics.Comic{} = comic, attrs) do
    comic
    |> Ecto.Changeset.cast(attrs, [:name, :url])
    |> Ecto.Changeset.validate_required([:name, :url])
    |> Ecto.Changeset.validate_length(:name, min: 2)
    |> Ecto.Changeset.validate_length(:url, min: 12)
    |> Ecto.Changeset.unique_constraint(:name)
    # do not use attrs.url since :url might be missing (weird since it is required)
    |> validate_start_with_http(:url, attrs[:url])
  end

  # missing :url already found by validate_required()
  defp validate_start_with_http(c, _field, nil), do: c
  defp validate_start_with_http(c, _field, "http://" <> _), do: c
  defp validate_start_with_http(c, _field, "https://" <> _), do: c

  defp validate_start_with_http(c, field, url),
    do: Ecto.Changeset.add_error(c, field, url <> ": does not start with http")
end
