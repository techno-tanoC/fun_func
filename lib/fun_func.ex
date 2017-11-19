defmodule FunFunc do
  @moduledoc ~S"""
  """

  @doc ~S"""
  See `FunFunc.Func.id/0`.

  ## Example
      iex> FunFunc.id().(1)
      1
  """
  defdelegate id, to: FunFunc.Func, as: :id

  @doc ~S"""
  See `FunFunc.Func.const/1`.

  ## Example
      iex> FunFunc.const(1).(2)
      1
  """
  defdelegate const(x), to: FunFunc.Func, as: :const

  @doc ~S"""
  See `FunFunc.Func.ignore/1`.

  ## Example
      iex> FunFunc.ignore(1).(2)
      2
  """
  defdelegate ignore(x), to: FunFunc.Func, as: :ignore

  @doc ~S"""
  See `FunFunc.Func.return/1`.

  ## Example
      iex> FunFunc.return(1).()
      1
  """
  defdelegate return(x), to: FunFunc.Func, as: :return

  defmacro __using(_opts) do
    quote do
      import FunFunc
    end
  end
end
