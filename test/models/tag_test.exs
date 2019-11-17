defmodule FacioApi.TagTest do
  use FacioApiWeb.ModelCase

  alias FacioApiWeb.Tag

  @valid_attrs %{name: "sport"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tag.changeset(%Tag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tag.changeset(%Tag{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "#find_or_create find a tag that already exists" do
    Repo.insert(%Tag{name: "sport"})

    tag = Repo.get_by(Tag, name: "sport")
    sport_tag = Tag.find_or_create name: "sport"

    assert tag.id == sport_tag.id
  end

  test "#find_or_create create a tag if does not exists" do
    tag = Repo.get_by(Tag, name: "sport")
    sport_tag = Tag.find_or_create name: "sport"

    assert tag == nil
    assert sport_tag != nil
  end
end
