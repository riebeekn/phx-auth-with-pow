defmodule WarehouseWeb.Pow.Messages do
  use Pow.Phoenix.Messages
  # since we're using the reset password and email confirmation
  # extensions we need to include them as well
  use Pow.Extension.Phoenix.Messages,
   extensions: [PowResetPassword, PowEmailConfirmation]

  import WarehouseWeb.Gettext

  def user_not_authenticated(_conn), do: gettext("You need to sign in to see this page.")
end
