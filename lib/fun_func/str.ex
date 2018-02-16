defmodule FunFunc.Str do
  @moduledoc ~S"""
  Functions for String.
  """

  @doc ~S"""
  Flipped `Regex.run`.

  See [`Regex.run`](https://hexdocs.pm/elixir/Regex.html#run/3) to use options.

  ## Examples
      iex> FunFunc.Str.run("abcd", ~r/c(d)/)
      ["cd", "d"]
      iex> FunFunc.Str.run("abcd", ~r/c(d)/, return: :index)
      [{2, 2}, {3, 1}]
  """
  def run(string, regex, options \\ []) do
    Regex.run(regex, string, options)
  end

  @doc ~S"""
  ## Examples
      iex> FunFunc.Str.empty?("")
      true
      iex> FunFunc.Str.empty?("    ")
      false
  """
  @spec empty?(charlist) :: boolean
  def empty?(string), do: string == ""

  @doc ~S"""
  ## Examples
      iex> FunFunc.Str.non_empty?("")
      false
      iex> FunFunc.Str.non_empty?("    ")
      true
  """
  @spec non_empty?(charlist) :: boolean
  def non_empty?(string), do: !empty?(string)

  @doc ~S"""
  ## Examples
      iex> FunFunc.Str.present?("\n")
      false
      iex> FunFunc.Str.present?("")
      false
      iex> FunFunc.Str.present?("    ")
      false
      iex> FunFunc.Str.present?("foo")
      true
  """
  @spec present?(charlist) :: boolean
  def present?(string), do: !blank?(string)

  @doc ~S"""
  ## Examples
      iex> FunFunc.Str.blank?("\n")
      true
      iex> FunFunc.Str.blank?("")
      true
      iex> FunFunc.Str.blank?("    ")
      true
      iex> FunFunc.Str.blank?("foo")
      false
  """
  @spec blank?(charlist) :: boolean
  def blank?(string) do
    String.trim(string) == ""
  end
end
