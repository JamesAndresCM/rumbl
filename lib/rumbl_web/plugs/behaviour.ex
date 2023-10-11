defmodule RumblWeb.Plugs.Behaviour do
  @callback init(opts :: any()) :: any()
  @callback call(conn :: Plug.Conn.t(), opts :: any()) :: Plug.Conn.t()
end
