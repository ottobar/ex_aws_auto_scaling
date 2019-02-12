defmodule ExAws.AutoScaling do
  @moduledoc """
  Operations on AWS Auto Scaling
  """

  # "DescribeAutoScalingInstances":{
  #   "name":"DescribeAutoScalingInstances",
  #   "http":{
  #     "method":"POST",
  #     "requestUri":"/"
  #   },
  #   "input":{"shape":"DescribeAutoScalingInstancesType"},
  #   "output":{
  #     "shape":"AutoScalingInstancesType",
  #     "resultWrapper":"DescribeAutoScalingInstancesResult"
  #   },
  #   "errors":[
  #     {"shape":"InvalidNextToken"},
  #     {"shape":"ResourceContentionFault"}
  #   ]
  # }

  # INPUT =>
  #
  # "DescribeAutoScalingInstancesType":{
  #   "type":"structure",
  #   "members":{
  #     "InstanceIds":{"shape":"InstanceIds"},
  #     "MaxRecords":{"shape":"MaxRecords"},
  #     "NextToken":{"shape":"XmlString"}
  #   }
  # }

  # OUTPUT =>
  #
  # "AutoScalingInstancesType":{
  #   "type":"structure",
  #   "members":{
  #     "AutoScalingInstances":{"shape":"AutoScalingInstances"},
  #     "NextToken":{"shape":"XmlString"}
  #   }
  # }
  #
  # "AutoScalingInstances":{
  #   "type":"list",
  #   "member":{"shape":"AutoScalingInstanceDetails"}
  # }
  #
  # "AutoScalingInstanceDetails":{
  #   "type":"structure",
  #   "required":[
  #     "InstanceId",
  #     "AutoScalingGroupName",
  #     "AvailabilityZone",
  #     "LifecycleState",
  #     "HealthStatus",
  #     "ProtectedFromScaleIn"
  #   ],
  #   "members":{
  #     "InstanceId":{"shape":"XmlStringMaxLen19"},
  #     "AutoScalingGroupName":{"shape":"XmlStringMaxLen255"},
  #     "AvailabilityZone":{"shape":"XmlStringMaxLen255"},
  #     "LifecycleState":{"shape":"XmlStringMaxLen32"},
  #     "HealthStatus":{"shape":"XmlStringMaxLen32"},
  #     "LaunchConfigurationName":{"shape":"XmlStringMaxLen255"},
  #     "LaunchTemplate":{"shape":"LaunchTemplateSpecification"},
  #     "ProtectedFromScaleIn":{"shape":"InstanceProtected"}
  #   }
  # }

  def describe_auto_scaling_instances(opts \\ []) do
    # TODO: params = build params here
    params = %{}
    request(:describe_auto_scaling_instances, params)
  end

  defp request(action, params) do
    action_string = action |> Atom.to_string() |> Macro.camelize()

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string),
      service: :autoscaling,
      action: action
      # TODO: parser: &ExAws.AutoScaling.Parsers.parse/2
    }
  end
end
