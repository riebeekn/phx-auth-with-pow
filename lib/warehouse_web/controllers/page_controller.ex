defmodule WarehouseWeb.PageController do
  use WarehouseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
