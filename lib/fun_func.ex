defmodule FunFunc do
  @moduledoc ~S"""
  This library provides helper functions.

  ## Sample

  ```
  use FunFunc
  Agent.start_link(return(1), name: __MODULE__)
  Agent.cast(__MODULE__, const(2))
  Agent.get(__MODULE__, id())
  ```

  ## `use`

  When `use FunFunc`, it means:

  ```
  import FunFunc
  alias FunFunc.{Func, Nilable, Num, Result, Tuple, Unit, Value}
  ```
  """

  @doc ~S"""
  See `FunFunc.Func.id/0`.

  ## Example
      iex> FunFunc.id().(1)
      1
  """
  @spec id() :: fun
  defdelegate id, to: FunFunc.Func, as: :id

  @doc ~S"""
  See `FunFunc.Func.const/1`.

  ## Example
      iex> FunFunc.const(1).(2)
      1
  """
  @spec const(any) :: fun
  defdelegate const(x), to: FunFunc.Func, as: :const

  @doc ~S"""
  See `FunFunc.Func.ignore/1`.

  ## Example
      iex> FunFunc.ignore(1).(2)
      2
  """
  @spec ignore(any) :: fun
  defdelegate ignore(x), to: FunFunc.Func, as: :ignore

  @doc ~S"""
  See `FunFunc.Func.return/1`.

  ## Example
      iex> FunFunc.return(1).()
      1
  """
  @spec return(any) :: fun
  defdelegate return(x), to: FunFunc.Func, as: :return

  defmacro __using(_opts) do
    quote do
      import FunFunc
      alias FunFunc.{Func, Nilable, Num, Result, Tuple, Unit, Value}
    end
  end
end
