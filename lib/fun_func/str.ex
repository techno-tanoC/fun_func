defmodule FunFunc.Str do
  @moduledoc ~S"""
  """

  @doc ~S"""
  Flipped `Regex.run`.

  ## Examples
      iex> FunFunc.Str.run("abcd", ~r/c(d)/)
      ["cd", "d"]
  """
  def run(string, regex, options \\ []) do
    Regex.run(regex, string, options)
  end
end
