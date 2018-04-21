defmodule FunFunc.Value do
  @moduledoc ~S"""
  Functions inspired by Ruby's ActiveSupport.
  """

  @doc ~S"""
  It returns the itself when the value is present, or returns nil.

  ## Examples
      iex> FunFunc.Value.presence(nil)
      nil
      iex> FunFunc.Value.presence(false)
      nil
      iex> FunFunc.Value.presence("")
      nil
      iex> FunFunc.Value.presence("     ")
      nil
      iex> FunFunc.Value.presence(%{})
      nil
      iex> FunFunc.Value.presence([])
      nil
      iex> FunFunc.Value.presence({})
      nil
      iex> FunFunc.Value.presence(1)
      1
  """
  def presence(x) do
    if present?(x), do: x
  end

  @doc ~S"""
  Checks the value is present.

  ## Examples
      iex> FunFunc.Value.present?(nil)
      false
      iex> FunFunc.Value.present?(false)
      false
      iex> FunFunc.Value.present?("")
      false
      iex> FunFunc.Value.present?("     ")
      false
      iex> FunFunc.Value.present?(%{})
      false
      iex> FunFunc.Value.present?([])
      false
      iex> FunFunc.Value.present?({})
      false
      iex> FunFunc.Value.present?(1)
      true
  """
  @spec present?(any) :: boolean
  def present?(x) do
    case x do
      nil   -> false
      false -> false
      ""    -> false
      %{}   -> not Enum.empty?(x)
      []    -> false
      {}    -> false
      x     -> cond do
        is_binary(x) -> String.trim(x) != ""
        true -> true
      end
    end
  end

  @doc ~S"""
  Returns the default value if it is present value.

  ## Examples
      iex> FunFunc.Value.present_or(1, 2)
      2
      iex> FunFunc.Value.present_or(nil, 1)
      nil
  """
  @spec present_or(any, any) :: any
  def present_or(x, default) do
    if present?(x), do: default, else: x
  end

  @doc ~S"""
  Lazy version of `present_or`.

  ## Examples
      iex> FunFunc.Value.present_or_else(1, fn -> 2 end)
      2
      iex> FunFunc.Value.present_or_else(nil, fn -> 1 end)
      nil
  """
  @spec present_or_else(any, (() -> any)) :: any
  def present_or_else(x, f) do
    if present?(x), do: f.(), else: x
  end

  @doc ~S"""
  The opposite of `present?`.

  ## Examples
      iex> FunFunc.Value.blank?(nil)
      true
      iex> FunFunc.Value.blank?(false)
      true
      iex> FunFunc.Value.blank?("")
      true
      iex> FunFunc.Value.blank?("     ")
      true
      iex> FunFunc.Value.blank?(%{})
      true
      iex> FunFunc.Value.blank?([])
      true
      iex> FunFunc.Value.blank?(1)
      false
  """
  @spec blank?(any) :: boolean
  def blank?(x), do: !present?(x)

  @doc ~S"""
  Returns the default value if it is blank value.

  ## Examples
      iex> FunFunc.Value.blank_or(1, 2)
      1
      iex> FunFunc.Value.blank_or(nil, 2)
      2
  """
  @spec blank_or(any, any) :: any
  def blank_or(x, default) do
    if blank?(x), do: default, else: x
  end

  @doc ~S"""
  Lazy version of `blank_or`.

  ## Examples
      iex> FunFunc.Value.blank_or_else(1, fn -> 2 end)
      1
      iex> FunFunc.Value.blank_or_else(nil, fn -> 2 end)
      2
  """
  @spec blank_or_else(any, (() -> any)) :: any
  def blank_or_else(x, f) do
    if blank?(x), do: f.(), else: x
  end

  @doc ~S"""
  Checks the value is empty.

  ## Examples
      iex> FunFunc.Value.empty?([])
      true
      iex> FunFunc.Value.empty?(%{})
      true
      iex> FunFunc.Value.empty?("")
      true
      iex> FunFunc.Value.empty?(1)
      false
  """
  @spec empty?(any) :: boolean
  def empty?(x) do
    case x do
      []  -> true
      %{} -> Enum.empty?(x)
      ""  -> true
      {}  -> true
      _   -> false
    end
  end

  @doc ~S"""
  Returns the default value if it is empty value.

  ## Examples
      iex> FunFunc.Value.empty_or(1, 2)
      1
      iex> FunFunc.Value.empty_or([], 2)
      2
  """
  @spec empty_or(any, any) :: any
  def empty_or(x, default) do
    if empty?(x), do: default, else: x
  end

  @doc ~S"""
  Lazy version of `empty_or`.

  ## Examples
      iex> FunFunc.Value.empty_or_else(1, fn -> 2 end)
      1
      iex> FunFunc.Value.empty_or_else([], fn -> 2 end)
      2
  """
  @spec empty_or_else(any, (() -> any)) :: any
  def empty_or_else(x, f) do
    if empty?(x), do: f.(), else: x
  end

  @doc ~S"""
  The opposite of `empty?`.

  ## Examples
      iex> FunFunc.Value.non_empty?([])
      false
      iex> FunFunc.Value.non_empty?(%{})
      false
      iex> FunFunc.Value.non_empty?("")
      false
      iex> FunFunc.Value.non_empty?(1)
      true
  """
  @spec non_empty?(any) :: boolean
  def non_empty?(x), do: !empty?(x)

  @doc ~S"""
  Returns the default value if it is not empty value.

  ## Examples
      iex> FunFunc.Value.non_empty_or(1, 2)
      2
      iex> FunFunc.Value.non_empty_or([], 2)
      []
  """
  @spec non_empty_or(any, any) :: any
  def non_empty_or(x, default) do
    if non_empty?(x), do: default, else: x
  end

  @doc ~S"""
  Lazy version of `non_empty_or`.

  ## Examples
      iex> FunFunc.Value.non_empty_or_else(1, fn -> 2 end)
      2
      iex> FunFunc.Value.non_empty_or_else([], fn -> 2 end)
      []
  """
  @spec non_empty_or_else(any, (() -> any)) :: any
  def non_empty_or_else(x, f) do
    if non_empty?(x), do: f.(), else: x
  end

  @doc ~S"""
  Returns `true` if not `false` nor `nil`.

  ## Examples
      iex> FunFunc.Value.truthy?(1)
      true
      iex> FunFunc.Value.truthy?(false)
      false
      iex> FunFunc.Value.truthy?(nil)
      false
  """
  @spec truthy?(any) :: boolean
  def truthy?(x) do
    if x do
      true
    else
      false
    end
  end

  @doc ~S"""
  The opposite of `truthy?/1`.

  ## Examples
      iex> FunFunc.Value.falsy?(1)
      false
      iex> FunFunc.Value.falsy?(false)
      true
      iex> FunFunc.Value.falsy?(nil)
      true
  """
  @spec falsy?(any) :: boolean
  def falsy?(x) do
    !truthy?(x)
  end
end
