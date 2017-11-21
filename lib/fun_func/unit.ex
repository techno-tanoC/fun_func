defmodule FunFunc.Unit do
  @moduledoc ~S"""
  Functions for units.

  `kilo`, `mega`, `giga`, `tera`, `peta`, `exa`, `milli`,
  `milli`, `micro`, `nano`, `pico`, `femto`, `atto` are supported.
  """

  define_unit = fn {unit, number} ->
    @doc ~s"""
    1 #{unit} is `#{number}`.

    ## Examples
        iex> FunFunc.Unit.#{unit}()
        #{number}
    """
    @spec unquote(unit)() :: number
    def unquote(unit)() do
      unquote(number)
    end

    @doc ~s"""
    See `#{unit}/0`.

    ## Examples
        iex> FunFunc.Unit.#{unit}(3)
        #{number * 3}
    """
    @spec unquote(unit)(number) :: number
    def unquote(unit)(x) do
      x * unquote(number)
    end
  end

  [:kilo, :mega, :giga, :tera, :peta, :exa]
  |> Enum.with_index(1)
  |> Enum.map(fn {unit, index} ->
    {unit, :math.pow(10, index * 3) |> round}
  end)
  |> Enum.each(define_unit)

  [:milli, :micro, :nano, :pico, :femto, :atto]
  |> Enum.with_index(1)
  |> Enum.map(fn {unit, index} ->
    {unit, :math.pow(10, index * -3)}
  end)
  |> Enum.each(define_unit)

  [:kilobyte, :megabyte, :gigabyte, :terabyte, :petabyte, :exabyte]
  |> Enum.with_index(1)
  |> Enum.map(fn {unit, index} ->
    {unit, :math.pow(2, index * 10) |> round}
  end)
  |> Enum.each(fn {unit, number} ->
    define_unit.({unit, number})

    @doc ~s"""
    Alias for `#{unit}/1`.

    ## Examples
        iex> FunFunc.Unit.#{unit}s(3)
        #{number * 3}
    """
    @spec unquote(:"#{unit}s")(number) :: number
    def unquote(:"#{unit}s")(x) do
      x * unquote(number)
    end
  end)
end
