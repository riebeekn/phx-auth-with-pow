defmodule Warehouse.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :name, :string
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :quantity])
    |> validate_required([:name, :quantity])
  end
end
