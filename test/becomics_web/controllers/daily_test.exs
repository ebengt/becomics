defmodule BecomicsWeb.Controllers.DailyTest do
  use ExUnit.Case

  test "day" do
    result = BecomicsWeb.DailyController.day_of_week_number()

    assert is_integer(result)
  end
end
