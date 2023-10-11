defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Multimedia.Category

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> unique_constraint(:title, name: "videos_user_id_title_index", message: "Title must be unique per user")
    |> assoc_constraint(:user)
  end

  def category_name(%{category: nil}), do: "No Category"
  defdelegate category_name(video), to: Category, as: :name
end
