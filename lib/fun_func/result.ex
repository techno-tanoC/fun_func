defmodule FunFunc.Result do
  @moduledoc ~S"""
  Functions for result values.
  The result value is `{:ok, x}` or `{:error, x}`.
  """

  @type result :: {atom, any}
  @type results :: [result]

  @doc ~S"""
  Creates a ok value.

  ## Example
      iex> FunFunc.Result.ok(1)
      {:ok, 1}
  """
  @spec ok(any) :: result
  def ok(x), do: {:ok, x}

  @doc ~S"""
  Creates a error value.

  ## Example
      iex> FunFunc.Result.error(1)
      {:error, 1}
  """
  @spec error(any) :: result
  def error(x), do: {:error, x}

  @doc ~S"""
  Checks the value is a ok value.

  ## Example
      iex> FunFunc.Result.ok?({:ok, 1})
      true
      iex> FunFunc.Result.ok?({:error, 1})
      false
      iex> FunFunc.Result.ok?(1)
      false
  """
  @spec ok?(any) :: boolean
  def ok?(result)
  def ok?({:ok, _}), do: true
  def ok?(_), do: false

  @doc ~S"""
  Checks the value is a error value.

  ## Example
      iex> FunFunc.Result.error?({:ok, 1})
      false
      iex> FunFunc.Result.error?({:error, 1})
      true
      iex> FunFunc.Result.error?(1)
      false
  """
  @spec error?(any) :: boolean
  def error?(result)
  def error?({:error, _}), do: true
  def error?(_), do: false

  @doc ~S"""
  Checks the value is the ok value or the error value.

  ## Example
      iex> FunFunc.Result.result?({:ok, 1})
      true
      iex> FunFunc.Result.result?({:error, 1})
      true
      iex> FunFunc.Result.result?(1)
      false
  """
  @spec result?(any) :: boolean
  def result?(result)
  def result?({:ok, _}), do: true
  def result?({:error, _}), do: true
  def result?(_), do: false

  @doc ~S"""
  Gets the value in the ok result, or gets the default value.

      iex> FunFunc.Result.ok_or({:ok, 1}, 2)
      1
      iex> FunFunc.Result.ok_or({:error, 1}, 2)
      2
      iex> FunFunc.Result.ok_or(1, 2)
      2
  """
  @spec ok_or(any, any) :: any
  def ok_or(result, default)
  def ok_or({:ok, x}, _), do: x
  def ok_or(_, default), do: default

  @doc ~S"""
  Gets the value in the ok result, or gets the result of the function.

      iex> FunFunc.Result.ok_or_else({:ok, 1}, fn -> 2 end)
      1
      iex> FunFunc.Result.ok_or_else({:error, 1}, fn -> 2 end)
      2
      iex> FunFunc.Result.ok_or_else(1, fn -> 2 end)
      2
  """
  @spec ok_or_else(any, fun) :: any
  def ok_or_else(result, default)
  def ok_or_else({:ok, x}, _), do: x
  def ok_or_else(_, default), do: default.()

  @doc ~S"""
  Gets the value in the error result, or gets the default value.

      iex> FunFunc.Result.error_or({:ok, 1}, 2)
      2
      iex> FunFunc.Result.error_or({:error, 1}, 2)
      1
      iex> FunFunc.Result.error_or(1, 2)
      2
  """
  @spec error_or(any, any) :: any
  def error_or(result, default)
  def error_or({:error, x}, _), do: x
  def error_or(_, default), do: default

  @doc ~S"""
  Gets the value in the error result, or gets the result of the function.

      iex> FunFunc.Result.error_or_else({:ok, 1}, fn -> 2 end)
      2
      iex> FunFunc.Result.error_or_else({:error, 1}, fn -> 2 end)
      1
      iex> FunFunc.Result.error_or_else(1, fn -> 2 end)
      2
  """
  @spec error_or_else(any, fun) :: any
  def error_or_else(result, default)
  def error_or_else({:error, x}, _), do: x
  def error_or_else(_, default), do: default.()

  @doc ~S"""
  Maps the inside value if the value is the ok value. Otherwise it returns the value itself.

  ## Example
      iex> FunFunc.Result.map({:ok, 1}, &Integer.to_string/1)
      {:ok, "1"}
      iex> FunFunc.Result.map({:error, 1}, &Integer.to_string/1)
      {:error, 1}
      iex> FunFunc.Result.map(1, &Integer.to_string/1)
      1
  """
  @spec map(result, fun) :: result
  def map(result, f)
  def map({:ok, x}, f), do: {:ok, f.(x)}
  def map({:error, _} = result, _), do: result
  def map(x, _), do: x

  @doc ~S"""
  Maps the inside value and flatten if the value is the ok value. Otherwise it returns the value itself.

  ## Example
      iex> FunFunc.Result.flat_map({:ok, 1}, &{:ok, &1 + 1})
      {:ok, 2}
      iex> FunFunc.Result.flat_map({:error, 1}, &{:ok, &1 + 1})
      {:error, 1}
      iex> FunFunc.Result.flat_map(1, &{:ok, &1 + 1})
      1
  """
  @spec flat_map(result, fun) :: result
  def flat_map(result, f)
  def flat_map({:ok, x}, f), do: f.(x)
  def flat_map({:error, _} = result, _), do: result
  def flat_map(result, _), do: result

  @doc ~S"""
  Maps the inside value if the value is the error value. Otherwise it returns the value itself.

  ## Example
      iex> FunFunc.Result.map_error({:ok, 1}, &Integer.to_string/1)
      {:ok, 1}
      iex> FunFunc.Result.map_error({:error, 1}, &Integer.to_string/1)
      {:error, "1"}
      iex> FunFunc.Result.map_error(1, &Integer.to_string/1)
      1
  """
  @spec map_error(result, fun) :: result
  def map_error(result, f)
  def map_error({:ok, _} = result, _), do: result
  def map_error({:error, x}, f), do: {:error, f.(x)}
  def map_error(result, _), do: result

  @doc ~S"""
  Maps the inside value and flatten if the value is the error value. Otherwise it returns the value itself.

  ## Example
      iex> FunFunc.Result.flat_map_error({:ok, 1}, &{:error, &1 + 1})
      {:ok, 1}
      iex> FunFunc.Result.flat_map_error({:error, 1}, &{:error, &1 + 1})
      {:error, 2}
      iex> FunFunc.Result.flat_map_error(1, &{:ok, &1 + 1})
      1
  """
  @spec flat_map_error(result, fun) :: result
  def flat_map_error(result, f)
  def flat_map_error({:ok, _} = result, _), do: result
  def flat_map_error({:error, x}, f), do: f.(x)
  def flat_map_error(result, _), do: result

  @doc ~S"""
  If the value is ok, applys the first function. If the value is error, applys the second function. Otherwise returns itself.

  ## Example
      iex> FunFunc.Result.join({:ok, 1}, &Integer.to_string/1, &Atom.to_string/1)
      "1"
      iex> FunFunc.Result.join({:error, :atom}, &Integer.to_string/1, &Atom.to_string/1)
      "atom"
      iex> FunFunc.Result.join(1, &Integer.to_string/1, &Atom.to_string/1)
      1
  """
  @spec join(result, fun, fun) :: any
  def join(result, f, g)
  def join({:ok, x}, f, _), do: f.(x)
  def join({:error, x}, _, g), do: g.(x)
  def join(result, _, _), do: result

  @doc ~S"""
  Collects only ok value.

      iex> FunFunc.Result.collect_oks([{:ok, 1}, {:error, 2}, 3])
      [1]
  """
  @spec collect_oks(results) :: list
  def collect_oks(results) do
    results
    |> Enum.filter(&ok?/1)
    |> Enum.map(fn {:ok, x} -> x end)
  end

  @doc ~S"""
  Collects only error value.

      iex> FunFunc.Result.collect_errors([{:ok, 1}, {:error, 2}, 3])
      [2]
  """
  @spec collect_errors(results) :: list
  def collect_errors(results) do
    results
    |> Enum.filter(&error?/1)
    |> Enum.map(fn {:error, x} -> x end)
  end

  @doc ~S"""
  Splits the result list. Non result value is ignored.

      iex> FunFunc.Result.split([{:ok, 1}, {:error, 2}, 3])
      {[1], [2]}
  """
  @spec split(results) :: {list, list}
  def split(results) do
    {oks, errors} = Enum.split_with(results, &ok?/1)
    {collect_oks(oks), collect_errors(errors)}
  end
end
