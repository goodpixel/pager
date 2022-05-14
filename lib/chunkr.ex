defmodule Chunkr do
  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @default_max_limit 100
  @default_cursor_mod Chunkr.Cursor.Base64
  @defaults [cursor_mod: @default_cursor_mod, max_limit: @default_max_limit]

  @doc false
  defmacro __using__(config) do
    quote do
      @chunkr_default_opts unquote(config) ++ [{:repo, __MODULE__} | unquote(@defaults)]

      def paginate!(queryable, strategy, sort_dir, opts) do
        Chunkr.Pagination.paginate!(queryable, strategy, sort_dir, opts ++ @chunkr_default_opts)
      end

      def paginate(queryable, strategy, sort_dir, opts) do
        Chunkr.Pagination.paginate(queryable, strategy, sort_dir, opts ++ @chunkr_default_opts)
      end
    end
  end

  @doc false
  def default_max_limit(), do: @default_max_limit

  @doc false
  def default_cursor_mod(), do: @default_cursor_mod
end
