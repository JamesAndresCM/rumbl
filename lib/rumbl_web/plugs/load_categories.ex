defmodule RumblWeb.Plugs.LoadCategories do
  use RumblWeb.Plugs.Base
  @behaviour RumblWeb.Plugs.Behaviour

  def init(default), do: default

  def call(conn, _opts) do
    assign(conn, :categories, Multimedia.list_alphabetical_categories())
  end
end
