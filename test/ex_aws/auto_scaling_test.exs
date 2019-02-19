defmodule ExAws.AutoScalingTest do
  use ExUnit.Case
  doctest ExAws.AutoScaling

  test "describe_auto_scaling_instances with no options" do
    expected = %ExAws.Operation.Query{
      action: :describe_auto_scaling_instances,
      params: %{
        "Action" => "DescribeAutoScalingInstances",
        "Version" => "2011-01-01"
      },
      parser: &ExAws.AutoScaling.Parsers.parse/2,
      path: "/",
      service: :autoscaling
    }

    actual = ExAws.AutoScaling.describe_auto_scaling_instances()
    assert actual == expected
  end

  test "describe_auto_scaling_instances with instance ids" do
    instance_id = "i-0598c7d356eba48d7"

    expected = %ExAws.Operation.Query{
      action: :describe_auto_scaling_instances,
      params: %{
        "Action" => "DescribeAutoScalingInstances",
        "Version" => "2011-01-01",
        "InstanceIds.member.1" => instance_id
      },
      parser: &ExAws.AutoScaling.Parsers.parse/2,
      path: "/",
      service: :autoscaling
    }

    actual = ExAws.AutoScaling.describe_auto_scaling_instances(instance_ids: [instance_id])

    assert actual == expected
  end
end
