defmodule FunFunc.Func do
  @moduledoc ~S"""
  Functions for generic purpose.
  """

  @doc ~S"""
  Identity function. It always returns the argument.

  ## Examples
      iex> FunFunc.Func.id().(1)
      1
  """
  @spec id() :: fun
  def id(), do: fn x -> x end

  @doc ~S"""
  Constant function. It returns the first argument.

  ## Examples
      iex> FunFunc.Func.const(1).(2)
      1
  """
  @spec const(any) :: fun
  def const(x), do: fn _ -> x end

  @doc ~S"""
  Ignore function. It returns the second argument.

  ## Examples
      iex> FunFunc.Func.ignore(1).(2)
      2
  """
  @spec ignore(any) :: fun
  def ignore(x)
  def ignore(_), do: fn x -> x end

  @doc ~S"""
  Return function. It returns the argument on the call.

  ## Examples
      iex> FunFunc.Func.return(1).()
      1
  """
  @spec return(any) :: fun
  def return(x), do: fn -> x end


  @doc ~S"""
  Composition function.

  ## Examples
      iex> FunFunc.Func.compose(&String.to_integer/1, &Integer.to_string/1).(1)
      1
  """
  @spec compose(fun, fun) :: fun
  def compose(f, g), do: fn x -> f.(g.(x)) end

  @doc ~S"""
  Curry function.

  ## Examples
      iex> FunFunc.Func.curry(&(&1 + &2)).(1).(2)
      3
      iex> FunFunc.Func.curry(&(&1 + &2 + &3)).(1).(2).(3)
      6
  """
  @spec curry(fun) :: fun
  def curry(f) do
    {_, arity} = :erlang.fun_info(f, :arity)
    do_curry(f, arity, [])
  end

  @doc false
  defp do_curry(f, 0, args), do: apply(f, Enum.reverse(args))
  defp do_curry(f, arity, args) do
    fn arg -> do_curry(f, arity - 1, [arg | args]) end
  end

  @doc ~S"""
  Applys args to the curried function.

  ## Examples
      iex> f = fn a -> fn b -> fn c -> a + b + c end end end
      iex> FunFunc.Func.apply_args(f, [1, 2, 3])
      6
  """
  @spec apply_args(fun, list) :: any
  def apply_args(f, args) do
    Enum.reduce(args, f, &(&2).(&1))
  end

  @doc ~S"""
  Flip function.

  ## Examples
      iex> FunFunc.Func.flip(&-/2).(1, 2)
      1
  """
  @spec flip(fun) :: fun
  def flip(f), do: fn a, b -> f.(b, a) end
end
