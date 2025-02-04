defmodule Becomics do
  @moduledoc """
  Becomics keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import Ecto.Query, warn: false
  alias Becomics.Repo

  def comic_like(name),
    do: Ecto.Query.from(c in Becomics.Comic, where: like(c.name, ^name)) |> Becomics.Repo.all()

  @doc """
  Return list of comics published on day

  ## Examples

  iex> select_comics_published_on("Thu")
  [%Comic{}, ...]
  """
  def select_comics_published_on(nil) do
    []
  end

  def select_comics_published_on(day) do
    Repo.all(
      from p in Becomics.Publish,
        where: p.day == ^day and not is_nil(p.comic_id),
        select: p.comic_id
    )
    |> Enum.map(&get_comic!/1)
  end

  @doc """
  Returns the list of comics.

  ## Examples

      iex> list_comics()
      [%Comic{}, ...]

  """
  def list_comics do
    Repo.all(Becomics.Comic)
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
  def get_comic!(id), do: Repo.get!(Becomics.Comic, id)

  @doc """
  Creates a comic.

  ## Examples

      iex> create_comic(%{field: value})
      {:ok, %Comic{}}

      iex> create_comic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comic(attrs \\ %{}) do
    %Becomics.Comic{}
    |> Becomics.Comic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comic.

  ## Examples

      iex> update_comic(comic, %{field: new_value})
      {:ok, %Becomics.Comic{}}

      iex> update_comic(comic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comic(%Becomics.Comic{} = comic, attrs) do
    comic
    |> Becomics.Comic.changeset(attrs)
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
  def delete_comic(%Becomics.Comic{} = comic) do
    Repo.delete(comic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comic changes.

  ## Examples

      iex> change_comic(comic)
      %Ecto.Changeset{source: %Comic{}}

  """
  def change_comic(%Becomics.Comic{} = comic) do
    Becomics.Comic.changeset(comic, %{})
  end

  def publishes_days(),
    do:
      Ecto.Query.from(c in Becomics.Publish, distinct: c.day, select: c.day)
      |> Becomics.Repo.all()

  def publish_from_comic(comic_id),
    do:
      Ecto.Query.from(c in Becomics.Publish, where: c.comic_id == ^comic_id)
      |> Becomics.Repo.all()

  @doc """
  Returns the list of publishes.

  ## Examples

      iex> list_publishes()
      [%Publish{}, ...]

  """
  def list_publishes do
    Repo.all(Becomics.Publish)
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
  def get_publish!(id), do: Repo.get!(Becomics.Publish, id)

  @doc """
  Creates a publish.

  ## Examples

      iex> create_publish(%{field: value})
      {:ok, %Publish{}}

      iex> create_publish(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_publish(attrs \\ %{}) do
    %Becomics.Publish{}
    |> Becomics.Publish.changeset(attrs)
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
  def update_publish(%Becomics.Publish{} = publish, attrs) do
    publish
    |> Becomics.Publish.changeset(attrs)
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
  def delete_publish(%Becomics.Publish{} = publish) do
    Repo.delete(publish)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking publish changes.

  ## Examples

      iex> change_publish(publish)
      %Ecto.Changeset{source: %Publish{}}

  """
  def change_publish(%Becomics.Publish{} = publish) do
    Becomics.Publish.changeset(publish, %{})
  end
end
