if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.AutoScaling.Parsers do
    use ExAws.Operation.Query.Parser

    def parse({:ok, %{body: xml} = resp}, :describe_auto_scaling_instances) do
      parsed_body =
        xml
        |> SweetXml.xpath(~x"//DescribeAutoScalingInstancesResponse",
          auto_scaling_instances: auto_scaling_instance_details_xml_description(),
          next_token: ~x"./DescribeAutoScalingInstancesResult/NextToken/text()"s,
          request_id: request_id_xpath()
        )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    defp auto_scaling_instance_details_xml_description do
      [
        ~x"./DescribeAutoScalingInstancesResult/AutoScalingInstances/member"l,
        auto_scaling_group_name: ~x"./AutoScalingGroupName/text()"s,
        availability_zone: ~x"./AvailabilityZone/text()"s,
        health_status: ~x"./HealthStatus/text()"s,
        instance_id: ~x"./InstanceId/text()"s,
        launch_configuration_name: ~x"./LaunchConfigurationName/text()"s,
        lifecycle_state: ~x"./LifecycleState/text()"s,
        protected_from_scale_in: ~x"./ProtectedFromScaleIn/text()"s |> to_boolean()
      ]
    end

    defp to_boolean(xpath) do
      xpath |> SweetXml.transform_by(&(&1 == "true"))
    end

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end
  end
else
  defmodule ExAws.SQS.Parsers do
    def parse(val, _), do: val
  end
end
