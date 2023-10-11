defmodule RumblWeb.Helpers.AuthHelpers do
  import Plug.Conn

  alias Rumbl.Accounts

  def login_user(conn, user) do
    token = Accounts.generate_user_session_token(user)

    conn
    |> fetch_session()
    |> put_session(:user_token, token)
    |> assign(:current_user, user)
  end
end
