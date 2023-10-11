defmodule RumblWeb.Plugs.LoadVideo do
  use RumblWeb.Plugs.Base
  @behaviour RumblWeb.Plugs.Behaviour

  def init(default), do: default

  def call(conn, _opts) do
    current_user = conn.assigns[:current_user]
    id = conn.params["id"]

    video = Multimedia.get_user_video(current_user, id)

    if video do
      assign(conn, :video, video)
    else
      conn
      |> put_flash(:error, "Video not found.")
      |> redirect(to: "/manage/videos/")
      |> halt()
    end
  end
end
