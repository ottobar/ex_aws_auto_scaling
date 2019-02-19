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
