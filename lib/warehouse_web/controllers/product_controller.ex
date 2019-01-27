defmodule WarehouseWeb.ProductController do
  use WarehouseWeb, :controller

  alias Warehouse.Inventory
  alias Warehouse.Inventory.Product

  def index(conn, _params) do
    products = Inventory.list_products()
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Inventory.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Inventory.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    changeset = Inventory.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Inventory.get_product!(id)

    case Inventory.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    {:ok, _product} = Inventory.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: Routes.product_path(conn, :index))
  end
end
