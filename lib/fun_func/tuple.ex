defmodule FunFunc.Tuple do
  @moduledoc ~S"""
  Functions for Tuple.
  These functions accept a arbitaly length tuple.
  """

  @doc ~S"""
  Takes the first value in the tuple.

      iex> FunFunc.Tuple.fst({1, 2})
      1
      iex> FunFunc.Tuple.fst({1, 2, 3})
      1
  """
  @spec fst(tuple) :: any
  def fst(tuple), do: elem(tuple, 0)

  @doc ~S"""
  Takes the second value in the tuple.

      iex> FunFunc.Tuple.snd({1, 2})
      2
      iex> FunFunc.Tuple.snd({1, 2, 3})
      2
  """
  @spec snd(tuple) :: any
  def snd(tuple), do: elem(tuple, 1)

  @doc ~S"""
  Maps the first value in the tuple.

      iex> FunFunc.Tuple.map_fst({1, 2}, &Integer.to_string/1)
      {"1", 2}
      iex> FunFunc.Tuple.map_fst({1, 2, 3}, &Integer.to_string/1)
      {"1", 2, 3}
  """
  @spec map_fst(tuple, fun) :: tuple
  def map_fst(tuple, f), do: map(tuple, 0, f)

  @doc ~S"""
  Maps the value in the tuple. The index is zero-index.

      iex> FunFunc.Tuple.map_snd({1, 2}, &Integer.to_string/1)
      {1, "2"}
      iex> FunFunc.Tuple.map_snd({1, 2, 3}, &Integer.to_string/1)
      {1, "2", 3}
  """
  @spec map_snd(tuple, fun) :: tuple
  def map_snd(tuple, f), do: map(tuple, 1, f)

  @doc ~S"""
  Maps the value in the tuple. The index is zero-index.

      iex> FunFunc.Tuple.map({1, 2}, 0, &Integer.to_string/1)
      {"1", 2}
      iex> FunFunc.Tuple.map({1, 2, 3}, 2, &Integer.to_string/1)
      {1, 2, "3"}
  """
  @spec map(tuple, integer, fun) :: tuple
  def map(tuple, index, f) do
    x = elem(tuple, index)
    tuple
    |> Tuple.delete_at(index)
    |> Tuple.insert_at(index, f.(x))
  end

  @doc ~S"""
  Swaps first two elements.

      iex> FunFunc.Tuple.swap({1, 2})
      {2, 1}
      iex> FunFunc.Tuple.swap({1, 2, 3})
      {2, 1, 3}
  """
  @spec swap(tuple) :: tuple
  def swap(tuple) do
    swap(tuple, 0, 1)
  end

  @doc ~S"""
  Swaps values in the tuple. The index is zero-index.

      iex> FunFunc.Tuple.swap({1, 2}, 0, 1)
      {2, 1}
      iex> FunFunc.Tuple.swap({1, 2, 3}, 1, 2)
      {1, 3, 2}
  """
  @spec swap(tuple, integer, integer) :: tuple
  def swap(tuple, i, j) do
    x = elem(tuple, i)
    y = elem(tuple, j)
    tuple
    |> Tuple.delete_at(i)
    |> Tuple.insert_at(i, y)
    |> Tuple.delete_at(j)
    |> Tuple.insert_at(j, x)
  end
end
