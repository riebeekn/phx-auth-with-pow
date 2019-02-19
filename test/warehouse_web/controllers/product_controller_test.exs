defmodule WarehouseWeb.ProductControllerTest do
  use WarehouseWeb.ConnCase

  alias Warehouse.Inventory

  @create_attrs %{name: "some name", quantity: 42}
  @update_attrs %{name: "some updated name", quantity: 43}
  @invalid_attrs %{name: nil, quantity: nil}

  def fixture(:product) do
    {:ok, product} = Inventory.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    user = user_fixture()
    conn = assign(conn, :current_user, user)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Products"
    end
  end

  describe "new product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "create product" do
    test "redirects to show when data is valid", %{conn: conn} do
      create_conn = post(conn, Routes.product_path(conn, :create), product: @create_attrs)

      assert %{id: id} = redirected_params(create_conn)
      assert redirected_to(create_conn) == Routes.product_path(create_conn, :show, id)

      show_conn = get(conn, Routes.product_path(conn, :show, id))
      assert html_response(show_conn, 200) =~ "Show Product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "edit product" do
    setup [:create_product]

    test "renders form for editing chosen product", %{conn: conn, product: product} do
      conn = get(conn, Routes.product_path(conn, :edit, product))
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "update product" do
    setup [:create_product]

    test "redirects when data is valid", %{conn: conn, product: product} do
      update_conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)
      assert redirected_to(update_conn) == Routes.product_path(update_conn, :show, product)

      show_conn = get(conn, Routes.product_path(conn, :show, product))
      assert html_response(show_conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      delete_conn = delete(conn, Routes.product_path(conn, :delete, product))
      assert redirected_to(delete_conn) == Routes.product_path(delete_conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.product_path(conn, :show, product))
      end
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    {:ok, product: product}
  end
end
