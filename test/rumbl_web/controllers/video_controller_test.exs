defmodule RumblWeb.VideoControllerTest do
  use RumblWeb.ConnCase

  import Rumbl.MultimediaFixtures
  import Rumbl.AccountsFixtures
  import RumblWeb.Helpers.AuthHelpers

  @create_attrs %{description: "some description", title: "some title", url: "some url"}
  @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{description: nil, title: nil, url: nil}

  setup %{conn: conn} do
    conn =
      conn
      |> Map.replace!(:secret_key_base, RumblWeb.Endpoint.config(:secret_key_base))
      |> init_test_session(%{})

    %{user: user_fixture(), conn: conn}
  end

  describe "index" do
    test "lists all videos", %{conn: conn, user: user} do
    conn = login_user(conn, user)
    conn = get(conn, ~p"/manage/videos")
    assert html_response(conn, 200) =~ "Listing Videos"
    end
  end

  describe "new video" do
    test "renders form", %{conn: conn, user: user} do
      conn = login_user(conn, user)
      conn = get(conn, ~p"/manage/videos/new")
      assert html_response(conn, 200) =~ "New Video"
    end
  end

  describe "create video" do
    test "redirects to show when data is valid", %{conn: conn, user: user} do
      conn = login_user(conn, user)
      category = category_fixture()
      merged_attrs = @create_attrs |> Map.merge(%{category_id: category.id})
      conn = post(conn, ~p"/manage/videos", video: merged_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/manage/videos/#{id}"

      conn = get(conn, ~p"/manage/videos/#{id}")
      assert html_response(conn, 200) =~ "Video #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = login_user(conn, user)
      conn = post(conn, ~p"/manage/videos", video: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Video"
    end
  end

  describe "edit video" do
    setup [:create_video]

    test "renders form for editing chosen video", %{conn: conn, video: video, user: user} do
      conn = login_user(conn, user)
      conn = get(conn, ~p"/manage/videos/#{video}/edit")
      assert html_response(conn, 200) =~ "Edit Video"
    end
  end

  describe "update video" do
    setup [:create_video]

    test "redirects when data is valid", %{conn: conn, video: video, user: user} do
      conn = login_user(conn, user)
      conn = put(conn, ~p"/manage/videos/#{video}", video: @update_attrs)
      assert redirected_to(conn) == ~p"/manage/videos/#{video}"

      conn = get(conn, ~p"/manage/videos/#{video}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, video: video, user: user} do
      conn = login_user(conn, user)
      conn = put(conn, ~p"/manage/videos/#{video.id}", video: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Video"
    end
  end

  describe "delete video" do
    setup [:create_video]

    test "deletes chosen video", %{conn: conn, video: video, user: user} do
      conn = login_user(conn, user)
      conn = delete(conn, ~p"/manage/videos/#{video}")
      assert redirected_to(conn) == ~p"/manage/videos"
    end
  end

  describe "show video" do
    setup [:create_video]

    test "renders video successfuly", %{conn: conn, video: video, user: user} do
      conn = login_user(conn, user)
      conn = get(conn, ~p"/manage/videos/#{video}")
      assert html_response(conn, 200) =~ video.title
    end

    test "video not found", %{conn: conn, user: user} do
      conn = login_user(conn, user)
      conn = get(conn, ~p"/manage/videos/-1")
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  defp create_video(_) do
    user = user_fixture()
    category = category_fixture()
    video = video_fixture(user, %{category_id: category.id})
    %{video: video, user: user, category: category}
  end
end
