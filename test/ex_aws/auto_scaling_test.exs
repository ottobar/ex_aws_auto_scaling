defmodule ExAws.AutoScalingTest do
  use ExUnit.Case
  doctest ExAws.AutoScaling

  test "describe_auto_scaling_instances" do
    expected = %{}
    actual = ExAws.AutoScaling.describe_auto_scaling_instances()
    assert actual == expected
  end
end
