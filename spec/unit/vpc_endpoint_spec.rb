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

    it 'outputs the VPC endpoint ID' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:vpc_endpoint_id)))
    end
  end

  describe 'when vpc_endpoint_service_name provided' do
    before(:context) do
      @region = var(role: :root, name: 'region')
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_name = "com.amazonaws.#{@region}.s3"
      end
    end

    it 'uses the provided service name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :service_name, "com.amazonaws.#{@region}.s3"
              ))
    end
  end

  describe 'when both vpc_endpoint_service_name and ' \
           'vpc_endpoint_common_service_name provided' do
    before(:context) do
      @region = var(role: :root, name: 'region')
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_name = "com.amazonaws.#{@region}.s3"
        vars.vpc_endpoint_service_common_name = 's3'
      end
    end

    it 'uses the provided service name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :service_name, "com.amazonaws.#{@region}.s3"
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

  context 'when custom tags provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 's3'
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
end
