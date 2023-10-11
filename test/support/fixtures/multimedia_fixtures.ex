defmodule Rumbl.MultimediaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rumbl.Multimedia` context.
  """

  @doc """
  Generate a video.
  """
  alias Rumbl.Accounts
  def video_fixture(%Accounts.User{} = user, attrs \\ %{}) do
    default_attrs = %{
        description: "some description",
        title: "some title",
        url: "some url",
        category_id: attrs[:category_id]
    }

    {:ok, video} = Rumbl.Multimedia.create_video(user, Enum.into(attrs, default_attrs))

    video
  end

  def category_fixture(attrs \\ %{}) do
    name = Map.get(attrs, :name, "some name")
    Rumbl.Multimedia.create_category!(name)
  end
end
