defmodule FunFunc.Num do
  @moduledoc ~S"""
  Functions for Number.
  """

  @doc ~S"""
  Returns division and remainder.

  ## Examples
      iex> FunFunc.Num.divmod(5, 2)
      {2, 1}
      iex> FunFunc.Num.divmod(5, 0)
      ** (ArithmeticError) bad argument in arithmetic expression
  """
  @spec divmod(integer, integer) :: {integer, integer}
  def divmod(x, y), do: {div(x, y), Integer.mod(x, y)}

  @doc ~S"""
  Checks the value is zero.

  ## Examples
      iex> FunFunc.Num.zero?(0)
      true
      iex> FunFunc.Num.zero?(1)
      false
  """
  @spec zero?(number) :: boolean
  def zero?(x), do: x == 0

  @doc ~S"""
  Checks the value is not zero.

  ## Examples
      iex> FunFunc.Num.non_zero?(0)
      false
      iex> FunFunc.Num.non_zero?(1)
      true
  """
  @spec non_zero?(number) :: boolean
  def non_zero?(x), do: !zero?(x)

  @doc ~S"""
  Checks the value is a positive number.

  ## Examples
      iex> FunFunc.Num.positive?(1)
      true
      iex> FunFunc.Num.positive?(0)
      false
      iex> FunFunc.Num.positive?(-1)
      false
  """
  @spec positive?(number) :: boolean
  def positive?(x), do: x > 0

  @doc ~S"""
  Checks the value is a negative number.

  ## Examples
      iex> FunFunc.Num.negative?(1)
      false
      iex> FunFunc.Num.negative?(0)
      false
      iex> FunFunc.Num.negative?(-1)
      true
  """
  @spec negative?(number) :: boolean
  def negative?(x), do: x < 0

  @doc ~S"""
  Successor function.

  ## Examples
      iex> FunFunc.Num.succ(41)
      42
  """
  @spec succ(integer) :: integer
  def succ(x), do: x + 1

  @doc ~S"""
  Predecessor function.

  ## Examples
      iex> FunFunc.Num.pred(43)
      42
  """
  @spec pred(integer) :: integer
  def pred(x), do: x - 1

  @doc ~S"""
  Iterates function for x times.

  ## Sample

  ```
  FunFunc.Num.times(3, &IO.puts/1)
  #=> 1
  #=> 2
  #=> 3
  :ok
  ```
  """
  @spec times(integer, fun) :: atom
  def times(x, f), do: 1..x |> Enum.each(f)
end
