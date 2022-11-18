defmodule BecomicsWeb.SampleControllerTest do
  use BecomicsWeb.ConnCase, async: true

  describe "sample list to get a slice. Size and start depending on how-many-samples and which-sample. Overlap of 1 should be provided." do
    test "survive no comics" do
      cs = BecomicsWeb.SampleController.test_select([], 10, 0, 0)
      assert cs === []
    end

    test "select 1 comics, if present" do
      cs = BecomicsWeb.SampleController.test_select([0], 1, 0, 0)
      assert cs === [0]
    end

    test "select 1 of 2 on first sample" do
      cs = BecomicsWeb.SampleController.test_select([0, 1], 2, 0, 0)
      assert cs === [0]
    end

    test "select 1 but no extra comics of 2 on last sample" do
      cs = BecomicsWeb.SampleController.test_select([0, 1], 2, 1, 1)
      assert cs === [1]
    end

    test "select 1 plus 1 extra comics of 3 on first sample" do
      cs = BecomicsWeb.SampleController.test_select([0, 1, 2], 3, 0, 1)
      assert cs === [0, 1]
    end

    test "select 1 plus 1 extra comics of 3 on second sample" do
      cs = BecomicsWeb.SampleController.test_select([0, 1, 2], 3, 1, 1)
      assert cs === [1, 2]
    end

    test "select 1 but no extra comics of 3 on last sample" do
      cs = BecomicsWeb.SampleController.test_select([0, 1, 2], 3, 2, 1)
      assert cs === [2]
    end

    test "select 3 plus 1 extra comics of 10 on first sample" do
      cs = BecomicsWeb.SampleController.test_select(Enum.to_list(0..9), 4, 0, 1)
      assert cs === [0, 1, 2, 3]
    end

    test "select 3 plus 1 extra comics of 10 on second sample" do
      cs = BecomicsWeb.SampleController.test_select(Enum.to_list(0..9), 4, 1, 1)
      assert cs === [3, 4, 5, 6]
    end

    test "select 2 plus 1 extra comics of 10 on third sample" do
      cs = BecomicsWeb.SampleController.test_select(Enum.to_list(0..9), 4, 2, 1)
     assert cs === [6, 7, 8]
    end

    test "select 2 comics of 10 on last sample" do
      cs = BecomicsWeb.SampleController.test_select(Enum.to_list(0..9), 4, 3, 1)
      assert cs === [8, 9]
    end
  end
  describe "sample list to get a slice given total number of samples." do
    test "select 1 comics each time, if total is all comcis" do
      cs = BecomicsWeb.SampleController.test_select_samples([1, 1], 2)
      assert cs === [1, 1]
    end

    test "select all comics, if total is 1" do
      cs = BecomicsWeb.SampleController.test_select_samples([1, 1], 1)
      assert cs === [2]
    end

    test "select from 10 comics, if total is 2" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 2)
      assert cs === [5, 5]
    end

    test "select from 10 comics, if total is 3" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 3)
      assert cs === [4, 3, 3]
    end

    test "select from 10 comics, if total is 4" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 4)
      assert cs === [3, 3, 2, 2]
    end

    test "select from 10 comics, if total is 5" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 5)
      assert cs === [2, 2, 2, 2, 2]
    end

    test "select from 10 comics, if total is 6" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 6)
      assert cs === [2, 2, 2, 2, 1, 1]
    end

    test "select from 10 comics, if total is 7" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 7)
      assert cs === [2, 2, 2, 1, 1, 1, 1]
    end

    test "select from 10 comics, if total is 8" do
      cs = BecomicsWeb.SampleController.test_select_samples(List.duplicate(1, 10), 8)
      assert cs === [2, 2, 1, 1, 1, 1, 1, 1]
    end
  end
end
