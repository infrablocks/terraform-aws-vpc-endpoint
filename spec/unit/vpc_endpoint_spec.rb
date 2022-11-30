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
      @plan = plan(role: :root)
    end

    it 'creates a VPC endpoint' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint'))
    end

    it 'outputs the VPC endpoint ID' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:vpc_endpoint_id)))
    end

    it 'includes component by default' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Component: component
                )
              ))
    end

    it 'includes deployment identifier by default' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  DeploymentIdentifier: deployment_identifier
                )
              ))
    end
  end

  context 'when custom tags provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.tags = { SomeTag: 'some-value' }
      end
    end

    it 'includes custom tag' do
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
