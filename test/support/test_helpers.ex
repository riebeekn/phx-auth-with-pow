defmodule Warehouse.TestHelpers do
  alias Warehouse.{Repo, Users.User}

  def user_fixture(attrs \\ %{}) do
    params =
      attrs
      |> Enum.into(%{
        email: "bob#{System.unique_integer([:positive])}@example.com",
        password: "abcdefghijk",
        confirm_password: "abcdefghijk",
        password_hash: "abcdefghijk"
      })

    {:ok, user} =
      User.changeset(%User{}, params)
      |> Repo.insert()

    user
  end
end
