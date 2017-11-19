defmodule FunFunc do
  @moduledoc ~S"""

  ## Sample

  ```
  use FunFunc
  Agent.start_link(return(1), name: __MODULE__)
  Agent.cast(__MODULE__, const(2))
  Agent.get(__MODULE__, id())
  ```

  when `use FunFunc`, It means:

  ```
  import FunFunc
  alias FunFunc.{Func, Result}
  ```
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
      alias FunFunc.{Func, Result}
    end
  end
end
