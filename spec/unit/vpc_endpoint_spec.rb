# frozen_string_literal: true

require 'spec_helper'

describe 'VPC endpoint' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 's3'
      end
    end

    it 'creates a VPC endpoint' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint'))
    end

    it 'resolves the service name based on the service common name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :service_name, 'com.amazonaws.eu-west-2.s3'
              ))
    end

    it 'uses the default VPC endpoint type of "Gateway"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(:vpc_endpoint_type, 'Gateway'))
    end

    it 'includes a component tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Component: component
                )
              ))
    end

    it 'includes a deployment identifier tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  DeploymentIdentifier: deployment_identifier
                )
              ))
    end

    it 'includes a name tag including component and deployment identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Name: including(component)
                          .and(including(deployment_identifier))
                )
              ))
    end

    it 'does not enable private DNS' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :private_dns_enabled, false
              ))
    end

    it 'outputs the VPC endpoint ID' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:vpc_endpoint_id)))
    end
  end

  describe 'when vpc_endpoint_service_name provided' do
    before(:context) do
      region = var(role: :root, name: 'region')
      @service_name = "vpce-svc-071afff70666e61e0.#{region}.vpce.amazonaws.com"
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_name = @service_name
        vars.vpc_endpoint_service_common_name = nil
      end
    end

    it 'uses the provided service name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :service_name, @service_name
              ))
    end
  end

  context 'when vpc_endpoint_type provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 'execute-api'
        vars.vpc_endpoint_type = 'Interface'
      end
    end

    it 'uses the provided VPC endpoint type' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(:vpc_endpoint_type, 'Interface'))
    end
  end

  describe 'when enable_private_dns is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        apply_defaults(vars)
        vars.enable_private_dns = true
      end
    end

    it 'enables private DNS' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :private_dns_enabled, true
              ))
    end
  end

  describe 'when enable_private_dns is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        apply_defaults(vars)
        vars.enable_private_dns = false
      end
    end

    it 'does not enable private DNS' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :private_dns_enabled, false
              ))
    end
  end

  context 'when custom tags provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        apply_defaults(vars)
        vars.tags = { SomeTag: 'some-value' }
      end
    end

    it 'includes a component tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Component: component
                )
              ))
    end

    it 'includes a deployment identifier tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  DeploymentIdentifier: deployment_identifier
                )
              ))
    end

    it 'includes a name tag including component and deployment identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Name: including(component)
                          .and(including(deployment_identifier))
                )
              ))
    end

    it 'includes the custom tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  SomeTag: 'some-value'
                )
              ))
    end
  end

  def apply_defaults(vars)
    vars.vpc_endpoint_service_common_name = 's3'
  end
end
