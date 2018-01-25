defmodule Becomics.Comics do
  @moduledoc """
  The Comics context.
  """

  import Ecto.Query, warn: false
  alias Becomics.Repo

  alias Becomics.Comics.Comic

	@doc """
	Return list of comics published on day
	
	## Examples
	
	iex> select_comics_published_on("Thu")
	[%Comic{}, ...]
	"""
	def select_comics_published_on day do
		(Repo.all from p in Becomics.Comics.Publish, where: p.day == ^day and not (is_nil p.comic_id), select: p.comic_id)
		|> (Enum.map &get_comic!/1)
	end

  @doc """
  Returns the list of comics.

  ## Examples

      iex> list_comics()
      [%Comic{}, ...]

  """
  def list_comics do
    Repo.all(Comic)
  end

  @doc """
  Gets a single comic.

  Raises `Ecto.NoResultsError` if the Comic does not exist.

  ## Examples

      iex> get_comic!(123)
      %Comic{}

      iex> get_comic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comic!(id), do: Repo.get!(Comic, id)

  @doc """
  Creates a comic.

  ## Examples

      iex> create_comic(%{field: value})
      {:ok, %Comic{}}

      iex> create_comic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comic(attrs \\ %{}) do
    %Comic{}
    |> Comic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comic.

  ## Examples

      iex> update_comic(comic, %{field: new_value})
      {:ok, %Comic{}}

      iex> update_comic(comic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comic(%Comic{} = comic, attrs) do
    comic
    |> Comic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comic.

  ## Examples

      iex> delete_comic(comic)
      {:ok, %Comic{}}

      iex> delete_comic(comic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comic(%Comic{} = comic) do
    Repo.delete(comic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comic changes.

  ## Examples

      iex> change_comic(comic)
      %Ecto.Changeset{source: %Comic{}}

  """
  def change_comic(%Comic{} = comic) do
    Comic.changeset(comic, %{})
  end

  alias Becomics.Comics.Publish

  @doc """
  Returns the list of publishes.

  ## Examples

      iex> list_publishes()
      [%Publish{}, ...]

  """
  def list_publishes do
    Repo.all(Publish)
  end

  @doc """
  Gets a single publish.

  Raises `Ecto.NoResultsError` if the Publish does not exist.

  ## Examples

      iex> get_publish!(123)
      %Publish{}

      iex> get_publish!(456)
      ** (Ecto.NoResultsError)

  """
  def get_publish!(id), do: Repo.get!(Publish, id)

  @doc """
  Creates a publish.

  ## Examples

      iex> create_publish(%{field: value})
      {:ok, %Publish{}}

      iex> create_publish(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_publish(attrs \\ %{}) do
    %Publish{}
    |> Publish.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a publish.

  ## Examples

      iex> update_publish(publish, %{field: new_value})
      {:ok, %Publish{}}

      iex> update_publish(publish, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_publish(%Publish{} = publish, attrs) do
    publish
    |> Publish.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Publish.

  ## Examples

      iex> delete_publish(publish)
      {:ok, %Publish{}}

      iex> delete_publish(publish)
      {:error, %Ecto.Changeset{}}

  """
  def delete_publish(%Publish{} = publish) do
    Repo.delete(publish)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking publish changes.

  ## Examples

      iex> change_publish(publish)
      %Ecto.Changeset{source: %Publish{}}

  """
  def change_publish(%Publish{} = publish) do
    Publish.changeset(publish, %{})
  end
end
