defmodule WarehouseWeb.Pow.Messages do
  use Pow.Phoenix.Messages
  # Note: if customizing the messages of an extension the
  # 'use Pow.Extension.Phoenix.Messages' statement is required
  # as well as a reference to the extension, i.e.
  # use Pow.Extension.Phoenix.Messages,
  #  extensions: [ResetPassword]

  import WarehouseWeb.Gettext

  def user_not_authenticated(_conn), do: gettext("You need to sign in to see this page.")
end
