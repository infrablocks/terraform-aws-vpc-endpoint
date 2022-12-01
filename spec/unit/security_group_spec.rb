# frozen_string_literal: true

require 'spec_helper'

describe 'VPC endpoint security group' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end
  let(:vpc_id) do
    output(role: :prerequisites, name: 'vpc_id')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 'execute-api'
        vars.vpc_endpoint_type = 'Interface'
      end
    end

    it 'creates a security group' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group')
              .once)
    end

    it 'derives the security group name from the component and ' \
       'deployment identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group')
              .with_attribute_value(
                :name, "#{component}-#{deployment_identifier}-vpc-endpoint"
              ))
    end

    it 'includes the component in the security group description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group')
              .with_attribute_value(:description, including(component)))
    end

    it 'includes the deployment identifier in the security group description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group')
              .with_attribute_value(
                :description, including(deployment_identifier)
              ))
    end

    it 'uses the provided VPC ID for the security group' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group')
              .with_attribute_value(:vpc_id, vpc_id))
    end

    it 'uses a from port of 0 for the egress rule' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group_rule')
              .with_attribute_value(:type, 'egress')
              .with_attribute_value(:from_port, 0))
    end

    it 'uses a to port of 0 for the egress rule' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group_rule')
              .with_attribute_value(:type, 'egress')
              .with_attribute_value(:to_port, 0))
    end

    it 'uses the VPC CIDR for the egress rule' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group_rule')
              .with_attribute_value(:type, 'ingress')
              .with_attribute_value(
                :cidr_blocks, [output(role: :prerequisites, name: 'vpc_cidr')]
              ))
    end

    it 'uses a protocol of -1 for the egress rule' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_security_group_rule')
              .with_attribute_value(:type, 'egress')
              .with_attribute_value(:protocol, '-1'))
    end
  end
end
