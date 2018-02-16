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
      iex> FunFunc.Value.presence(%{})
      nil
      iex> FunFunc.Value.presence([])
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
      iex> FunFunc.Value.present?(%{})
      false
      iex> FunFunc.Value.present?([])
      false
      iex> FunFunc.Value.present?(1)
      true
  """
  @spec present?(any) :: boolean
  def present?(x) do
    case x do
      nil   -> false
      false -> false
      []    -> false
      %{}   -> not Enum.empty?(x)
      ""    -> false
      _     -> true
    end
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
      _   -> false
    end
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
