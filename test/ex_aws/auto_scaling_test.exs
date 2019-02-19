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

  test "record_lifecycle_action_heartbeat with no options" do
    auto_scaling_group_name = "my-asg"
    lifecycle_hook_name = "my-hook"

    expected = %ExAws.Operation.Query{
      action: :record_lifecycle_action_heartbeat,
      params: %{
        "AutoScalingGroupName" => auto_scaling_group_name,
        "LifecycleHookName" => lifecycle_hook_name,
        "Action" => "RecordLifecycleActionHeartbeat",
        "Version" => "2011-01-01"
      },
      parser: &ExAws.AutoScaling.Parsers.parse/2,
      path: "/",
      service: :autoscaling
    }

    actual =
      ExAws.AutoScaling.record_lifecycle_action_heartbeat(
        auto_scaling_group_name,
        lifecycle_hook_name
      )

    assert actual == expected
  end

  test "record_lifecycle_action_heartbeat with instance id" do
    auto_scaling_group_name = "my-asg"
    lifecycle_hook_name = "my-hook"
    instance_id = "i-0598c7d356eba48d7"

    expected = %ExAws.Operation.Query{
      action: :record_lifecycle_action_heartbeat,
      params: %{
        "AutoScalingGroupName" => auto_scaling_group_name,
        "LifecycleHookName" => lifecycle_hook_name,
        "InstanceId" => instance_id,
        "Action" => "RecordLifecycleActionHeartbeat",
        "Version" => "2011-01-01"
      },
      parser: &ExAws.AutoScaling.Parsers.parse/2,
      path: "/",
      service: :autoscaling
    }

    actual =
      ExAws.AutoScaling.record_lifecycle_action_heartbeat(
        auto_scaling_group_name,
        lifecycle_hook_name,
        instance_id: instance_id
      )

    assert actual == expected
  end

  test "record_lifecycle_action_heartbeat with lifecycle action token" do
    auto_scaling_group_name = "my-asg"
    lifecycle_hook_name = "my-hook"
    lifecycle_action_token = "71514b9d-6a40-4b26-8523-05e7ee35fa40"

    expected = %ExAws.Operation.Query{
      action: :record_lifecycle_action_heartbeat,
      params: %{
        "AutoScalingGroupName" => auto_scaling_group_name,
        "LifecycleHookName" => lifecycle_hook_name,
        "LifecycleActionToken" => lifecycle_action_token,
        "Action" => "RecordLifecycleActionHeartbeat",
        "Version" => "2011-01-01"
      },
      parser: &ExAws.AutoScaling.Parsers.parse/2,
      path: "/",
      service: :autoscaling
    }

    actual =
      ExAws.AutoScaling.record_lifecycle_action_heartbeat(
        auto_scaling_group_name,
        lifecycle_hook_name,
        lifecycle_action_token: lifecycle_action_token
      )

    assert actual == expected
  end
end
