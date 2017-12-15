defmodule FacioApi.ListTest do
  use FacioApi.ModelCase

  alias FacioApi.List
  alias Authable.Model.User

  @missing_user_attrs %{title: "Test", user: ""}
  @missing_title_attrs %{user: ""}
  @long_title_attr %{title: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", user: ""}
  @short_title_attr %{title: "L", user: ""}

  test "validates presence of user" do
    assert {:user_id, "can't be blank"} in errors_on(%List{}, @missing_user_attrs)

    Repo.insert(%User{email: "test@gmail.com", password: "foobarfoo"})

    user = Repo.get_by(User, email: "test@gmail.com")

    Repo.insert(%List{title: "New title", user: user})

    list = Repo.get_by(List, title: "New title") |> Repo.preload([:user])

    assert list.user == user
  end

  test "valides presence of title" do
    assert {:title, "can't be blank"} in errors_on(%List{}, @missing_title_attrs)
  end

  test "validates length of title" do
    assert {:title, "should be at most 40 character(s)"} in errors_on(%List{}, @long_title_attr)
    assert {:title, "should be at least 3 character(s)"} in errors_on(%List{}, @short_title_attr)
  end

end
