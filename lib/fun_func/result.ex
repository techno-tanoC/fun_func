defmodule FunFunc.Result do
  @moduledoc ~S"""
  """

  @type result :: {any, any}

  @doc ~S"""
  Creates a ok value.

  ## Example
      iex> FunFunc.Result.ok(1)
      {:ok, 1}
  """
  def ok(x), do: {:ok, x}

  @doc ~S"""
  Creates a error value.

  ## Example
      iex> FunFunc.Result.error(1)
      {:error, 1}
  """
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
  def result?(result)
  def result?({:ok, _}), do: true
  def result?({:error, _}), do: true
  def result?(_), do: false

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
  def join(result, f, g)
  def join({:ok, x}, f, _), do: f.(x)
  def join({:error, x}, _, g), do: g.(x)
  def join(result, _, _), do: result

  @doc ~S"""
  Collects only ok value.

  iex> FunFunc.Result.collect_oks([{:ok, 1}, {:error, 2}, 3])
  [1]
  """
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
  def split(results) do
    {oks, errors} = Enum.split_with(results, &ok?/1)
    {collect_oks(oks), collect_errors(errors)}
  end
end
