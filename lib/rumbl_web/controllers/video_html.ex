defmodule RumblWeb.VideoHTML do
  use RumblWeb, :html

  embed_templates "video_html/*"

  @doc """
  Renders a video form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def video_form(assigns)

  def category_select_options(categories) do
    for category <- categories, do: {category.name, category.id}
  end

  def video_category_name(video) do
    Rumbl.Multimedia.Video.category_name(video)
  end
end
