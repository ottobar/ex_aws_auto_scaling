defmodule ExAws.AutoScaling do
  @moduledoc """
  Operations on AWS EC2 Auto Scaling

  A work-in-progress selection of operations from the
  [Amazon EC2 Auto Scaling API](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_Operations_List.html).

  Examples of how to use this:
  ```elixir
  ExAws.AutoScaling.describe_auto_scaling_instances(
    instance_ids: ["i-0598c7d356eba48d7", "i-1234567890abcdef0"]
  )
  ```
  """

  use ExAws.Utils,
    format_type: :xml,
    non_standard_keys: %{}

  @version "2011-01-01"

  @type lifecycle_action_opts :: [
          instance_id: binary,
          lifecycle_action_token: binary
        ]

  @doc """
  Completes the lifecycle action for the specified token or instance with the specified result.

  Doc: https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CompleteLifecycleAction.html
  """
  @type lifecycle_action_result :: :continue | :abandon
  @spec complete_lifecycle_action(
          auto_scaling_group_name :: binary,
          lifecycle_hook_name :: binary,
          lifecycle_action_result :: lifecycle_action_result
        ) :: ExAws.Operation.Query.t()
  @spec complete_lifecycle_action(
          auto_scaling_group_name :: binary,
          lifecycle_hook_name :: binary,
          lifecycle_action_result :: lifecycle_action_result,
          opts :: lifecycle_action_opts
        ) :: ExAws.Operation.Query.t()
  def complete_lifecycle_action(
        auto_scaling_group_name,
        lifecycle_hook_name,
        lifecycle_action_result,
        opts \\ []
      ) do
    lifecycle_action_result_name =
      lifecycle_action_result
      |> Atom.to_string()
      |> String.upcase()

    [
      {"AutoScalingGroupName", auto_scaling_group_name},
      {"LifecycleHookName", lifecycle_hook_name},
      {"LifecycleActionResult", lifecycle_action_result_name}
      | opts
    ]
    |> build_request(:complete_lifecycle_action)
  end

  @doc """
  Describes one or more Auto Scaling instances.

  Doc: https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeAutoScalingInstances.html
  """
  @type describe_auto_scaling_instances_opts :: [
          instance_ids: [binary, ...],
          max_records: integer,
          next_token: binary
        ]
  @spec describe_auto_scaling_instances() :: ExAws.Operation.Query.t()
  @spec describe_auto_scaling_instances(opts :: describe_auto_scaling_instances_opts) ::
          ExAws.Operation.Query.t()
  def describe_auto_scaling_instances(opts \\ []) do
    opts |> build_request(:describe_auto_scaling_instances)
  end

  @doc """
  Records a heartbeat for the lifecycle action associated with the specified token or instance.

  Doc: https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_RecordLifecycleActionHeartbeat.html
  """
  @spec record_lifecycle_action_heartbeat(
          auto_scaling_group_name :: binary,
          lifecycle_hook_name :: binary
        ) :: ExAws.Operation.Query.t()
  @spec record_lifecycle_action_heartbeat(
          auto_scaling_group_name :: binary,
          lifecycle_hook_name :: binary,
          opts :: lifecycle_action_opts
        ) :: ExAws.Operation.Query.t()
  def record_lifecycle_action_heartbeat(auto_scaling_group_name, lifecycle_hook_name, opts \\ []) do
    [
      {"AutoScalingGroupName", auto_scaling_group_name},
      {"LifecycleHookName", lifecycle_hook_name}
      | opts
    ]
    |> build_request(:record_lifecycle_action_heartbeat)
  end

  defp build_request(opts, action) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(action)
  end

  defp request(params, action) do
    action_string = action |> Atom.to_string() |> Macro.camelize()

    %ExAws.Operation.Query{
      path: "/",
      params:
        params
        |> filter_nil_params
        |> Map.put("Action", action_string)
        |> Map.put("Version", @version),
      service: :autoscaling,
      action: action,
      parser: &ExAws.AutoScaling.Parsers.parse/2
    }
  end

  defp format_param({:instance_ids, instance_ids}) do
    instance_ids |> format(prefix: "InstanceIds.member")
  end

  defp format_param({key, parameters}) do
    format([{key, parameters}])
  end
end
