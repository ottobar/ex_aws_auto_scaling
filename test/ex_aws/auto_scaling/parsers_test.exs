defmodule ExAws.AutoScaling.ParsersTest do
  use ExUnit.Case
  doctest ExAws.AutoScaling.Parsers

  test "parse complete_lifecycle_action response" do
    request_id = "18b2ec17-3e9b-4c15-8024-ff2e8ce8786a"

    response =
      """
      <CompleteLifecycleActionResponse xmlns="http://autoscaling.amazonaws.com/doc/2011-01-01/">
          <CompleteLifecycleActionResult/>
          <ResponseMetadata>
              <RequestId>#{request_id}</RequestId>
          </ResponseMetadata>
      </CompleteLifecycleActionResponse>
      """
      |> to_success

    {:ok, %{body: parsed_response}} =
      ExAws.AutoScaling.Parsers.parse(response, :complete_lifecycle_action)

    assert parsed_response.request_id == request_id
  end

  test "parse describe_auto_scaling_instances response" do
    auto_scaling_group_name = "my-asg"
    availability_zone = "us-east-1b"
    health_status = "HEALTHY"
    instance_id = "i-0598c7d356eba48d7"
    launch_configuration_name = "my-lc"
    lifecycle_state = "InService"
    protected_from_scale_in = "false"
    next_token = "ce65a3b8-c276-7013-c50f-1c0d5442f59f"
    request_id = "18b2ec17-3e9b-4c15-8024-ff2e8ce8786a"

    response =
      """
      <DescribeAutoScalingInstancesResponse xmlns="http://autoscaling.amazonaws.com/doc/2011-01-01/">
          <DescribeAutoScalingInstancesResult>
              <AutoScalingInstances>
                  <member>
                      <AutoScalingGroupName>#{auto_scaling_group_name}</AutoScalingGroupName>
                      <AvailabilityZone>#{availability_zone}</AvailabilityZone>
                      <HealthStatus>#{health_status}</HealthStatus>
                      <InstanceId>#{instance_id}</InstanceId>
                      <LaunchConfigurationName>#{launch_configuration_name}</LaunchConfigurationName>
                      <LifecycleState>#{lifecycle_state}</LifecycleState>
                      <ProtectedFromScaleIn>#{protected_from_scale_in}</ProtectedFromScaleIn>
                  </member>
              </AutoScalingInstances>
              <NextToken>#{next_token}</NextToken>
          </DescribeAutoScalingInstancesResult>
          <ResponseMetadata>
              <RequestId>#{request_id}</RequestId>
          </ResponseMetadata>
      </DescribeAutoScalingInstancesResponse>
      """
      |> to_success

    {:ok, %{body: parsed_response}} =
      ExAws.AutoScaling.Parsers.parse(response, :describe_auto_scaling_instances)

    parsed_auto_scaling_instance = hd(parsed_response.auto_scaling_instances)

    assert length(parsed_response.auto_scaling_instances) == 1
    assert parsed_auto_scaling_instance.auto_scaling_group_name == auto_scaling_group_name
    assert parsed_auto_scaling_instance.availability_zone == availability_zone
    assert parsed_auto_scaling_instance.instance_id == instance_id
    assert parsed_auto_scaling_instance.launch_configuration_name == launch_configuration_name
    assert parsed_auto_scaling_instance.lifecycle_state == lifecycle_state
    assert parsed_auto_scaling_instance.protected_from_scale_in == false
    assert parsed_response.next_token == next_token
    assert parsed_response.request_id == request_id
  end

  test "parse record_lifecycle_action_heartbeat response" do
    request_id = "18b2ec17-3e9b-4c15-8024-ff2e8ce8786a"

    response =
      """
      <RecordLifecycleActionHeartbeatResponse xmlns="http://autoscaling.amazonaws.com/doc/2011-01-01/">
          <RecordLifecycleActionHeartbeatResult/>
          <ResponseMetadata>
              <RequestId>#{request_id}</RequestId>
          </ResponseMetadata>
      </RecordLifecycleActionHeartbeatResponse>
      """
      |> to_success

    {:ok, %{body: parsed_response}} =
      ExAws.AutoScaling.Parsers.parse(response, :record_lifecycle_action_heartbeat)

    assert parsed_response.request_id == request_id
  end

  defp to_success(doc) do
    {:ok, %{body: doc}}
  end
end
