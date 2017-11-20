defmodule FunFunc.Nilable do
  @moduledoc ~S"""
  """

  @type nilable :: nil | any
  @type func :: (nilable -> nilable)

  @doc ~S"""
  Maps if the first argument is not nil. Otherwise returns nil.

  ## Example
      iex> FunFunc.Nilable.map(1, &Integer.to_string/1)
      "1"
      iex> FunFunc.Nilable.map(nil, &Integer.to_string/1)
      nil
  """
  @spec map(nilable, func) :: nilable
  def map(x, f)
  def map(nil, _), do: nil
  def map(x, f), do: f.(x)

  @doc ~S"""
  Gets the first argument if it is not nil. Otherwise returns the default value.

  ## Example
      iex> FunFunc.Nilable.get_or(1, 2)
      1
      iex> FunFunc.Nilable.get_or(nil, 2)
      2
  """
  @spec get_or(nilable, any) :: any
  def get_or(x, default)
  def get_or(nil, default), do: default
  def get_or(x, _), do: x

  @doc ~S"""
  Gets the first argument if it is not nil. Otherwise returns the result of the function.

  ## Example
      iex> FunFunc.Nilable.get_or_else(1, fn -> 2 end)
      1
      iex> FunFunc.Nilable.get_or_else(nil, fn -> 2 end)
      2
  """
  @spec get_or_else(nilable, fun) :: any
  def get_or_else(x, default)
  def get_or_else(nil, default), do: default.()
  def get_or_else(x, _), do: x

  @doc ~S"""
  Maps the first argument if it is not nil. Otherwise returns the default value.

  ## Example
      iex> FunFunc.Nilable.maybe(1, &Integer.to_string/1, "default")
      "1"
      iex> FunFunc.Nilable.maybe(nil, &Integer.to_string/1, "default")
      "default"
  """
  @spec maybe(nilable, fun, any) :: any
  def maybe(x, f, default)
  def maybe(nil, _, default), do: default
  def maybe(x, f, _), do: f.(x)

  @doc ~S"""
  Maps the first argument if it is not nil. Otherwise returns the result of the function.

  ## Example
      iex> FunFunc.Nilable.maybe_else(1, &Integer.to_string/1, fn -> "default" end)
      "1"
      iex> FunFunc.Nilable.maybe_else(nil, &Integer.to_string/1, fn -> "default" end)
      "default"
  """
  @spec maybe_else(nilable, fun, fun) :: any
  def maybe_else(x, f, default)
  def maybe_else(nil, _, default), do: default.()
  def maybe_else(x, f, _), do: f.(x)

  @doc ~S"""
  _and_

  If the first argument is `nil`, `nil` is returned. Otherwise, the second argument is returned.

  ## Example
  iex> FunFunc.Nilable.nil_and(nil, 2)
  nil
  iex> FunFunc.Nilable.nil_and(1, nil)
  nil
  iex> FunFunc.Nilable.nil_and(1, 2)
  2
  """
  @spec nil_and(nilable, nilable) :: nilable
  def nil_and(x, y)
  def nil_and(nil, _), do: nil
  def nil_and(_, y), do: y

  @doc ~S"""
  _or_

  If the first argument is `nil`, the second argument is returned. Otherwise, the first argument is returnded.

  ## Example
  iex> FunFunc.Nilable.nil_or(nil, 2)
  2
  iex> FunFunc.Nilable.nil_or(1, nil)
  1
  iex> FunFunc.Nilable.nil_or(nil, nil)
  nil
  """
  @spec nil_or(nilable, nilable) :: nilable
  def nil_or(x, y)
  def nil_or(nil, y), do: y
  def nil_or(x, _), do: x
end
