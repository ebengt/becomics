defmodule Becomics.Comics.Comic do
  use Ecto.Schema
#  import Ecto.Changeset
  alias Becomics.Comics.Comic


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comics" do
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Comic{} = comic, attrs) do
    comic
    |> Ecto.Changeset.cast(attrs, [:name, :url])
    |> Ecto.Changeset.validate_required([:name, :url])
    |> Ecto.Changeset.validate_length(:name, min: 2)
    |> Ecto.Changeset.validate_length(:url, min: 12)
    |> validate_start_with_http(:url, attrs[:url]) # do not use attrs.url since :url might be missing
  end


	defp validate_start_with_http(c, _field, nil ), do: c # missing :url already found by validate_required()
	defp validate_start_with_http(c, _field, "http://" <> _ ), do: c
	defp validate_start_with_http(c, _field, "https://" <> _ ), do: c
	defp validate_start_with_http(c, field, url ), do: Ecto.Changeset.add_error c, field, url <> ": does not start with http"
end
