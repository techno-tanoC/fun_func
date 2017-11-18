defmodule FunFunc.Func do
  @moduledoc ~S"""
  """

  @doc ~S"""
  Identity function.

      iex> FunFunc.Func.id().(1)
      1
  """
  @spec id() :: fun
  def id(), do: fn x -> x end

  @doc ~S"""
  Constant function.

      iex> FunFunc.Func.const(1).(2)
      1
  """
  @spec const(any) :: fun
  def const(x), do: fn _ -> x end

  @doc ~S"""
  Return function.

      iex> FunFunc.Func.return(1).()
      1
  """
  @spec return(any) :: fun
  def return(x), do: fn -> x end
end
