defmodule FacioApi.ItemTest do
  use FacioApiWeb.ModelCase

  alias FacioApiWeb.Item

  @short_label_attr %{label: "s"}
  @long_label_attr %{label: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "}
  @too_big_value_attr %{label: "test", value: 8}

  test "valides presence of label" do
    assert {:label, "can't be blank"} in errors_on(%Item{}, %{})
  end

  test "validates length of label" do
    assert {:label, "should be at least 2 character(s)"} in errors_on(%Item{}, @short_label_attr)
    assert {:label, "should be at most 40 character(s)"} in errors_on(%Item{}, @long_label_attr)
  end

  test "validates value of value" do
    assert {:value, "must be less than 6"} in errors_on(%Item{}, @too_big_value_attr)
  end
end
