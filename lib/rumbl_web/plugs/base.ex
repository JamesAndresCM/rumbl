defmodule RumblWeb.Plugs.Base do
  defmacro __using__(_) do
    quote do
      import Phoenix.Controller
      import Plug.Conn
      alias Rumbl.Multimedia
    end
  end
end
