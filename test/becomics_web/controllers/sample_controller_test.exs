defmodule BecomicsWeb.SampleControllerTest do
  use BecomicsWeb.ConnCase, async: true

	describe "sample list to get a slice. Size and start depending on how-many-samples and which-sample. Overlap of 1 should be provided." do
		test "survive 0 comics" do
			cs = BecomicsWeb.SampleController.select [], 10, 0
			assert cs === []
		end
		test "select 1 comics if present no mather how-many-samples" do
			cs = BecomicsWeb.SampleController.select [0], 10, 0
			assert cs === [0]
		end
		test "select 1 plus 1 extra of 2 on first sample" do
			cs = BecomicsWeb.SampleController.select [0, 1], 2, 0
			assert cs === [0, 1]
		end
		test "select 1 but no extra comics of 2 on last sample" do
			cs = BecomicsWeb.SampleController.select [0, 1], 2, 1
			assert cs === [1]
		end
		test "select 1 plus 1 extra comics of 3 on first sample" do
			cs = BecomicsWeb.SampleController.select [0, 1, 2], 3, 0
			assert cs === [0, 1]
		end
		test "select 1 plus 1 extra comics of 3 on second sample" do
			cs = BecomicsWeb.SampleController.select [0, 1, 2], 3, 1
			assert cs === [1, 2]
		end
		test "select 1 but no extra comics of 3 on last sample" do
			cs = BecomicsWeb.SampleController.select [0, 1, 2], 3, 2
			assert cs === [2]
		end
		test "select 3 plus 1 extra comics of 10 on first sample" do
			cs = BecomicsWeb.SampleController.select  (Enum.to_list 0..9), 4, 0
			assert cs === [0, 1,2,3]
		end
		test "select 3 plus 1 extra comics of 10 on second sample" do
			cs = BecomicsWeb.SampleController.select  (Enum.to_list 0..9), 4, 1
			assert cs === [3,4,5,6]
		end
		test "select 3 plus 1 extra comics of 10 on third sample" do
			cs = BecomicsWeb.SampleController.select  (Enum.to_list 0..9), 4, 2
			assert cs === [5,6,7,8]
		end
		test "select 2 comics of 10 on last sample" do
			cs = BecomicsWeb.SampleController.select  (Enum.to_list 0..9), 4, 3
			assert cs === [8,9]
		end
	end
end
