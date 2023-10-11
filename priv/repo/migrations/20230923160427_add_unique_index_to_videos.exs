defmodule Rumbl.Repo.Migrations.AddUniqueIndexToVideos do
  use Ecto.Migration

  def change do
    create unique_index(:videos, [:user_id, :title])
  end
end
