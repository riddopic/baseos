# Encoding: utf-8

require_relative 'spec_helper'

describe 'baseos::default' do
  before { stub_resources }
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(
            platform:  platform,
            version:   version,
            log_level: LOG_LEVEL
          ) do |node|
            # node_resources(node)
            node.set[:one][:two] = 3
          end.converge(described_recipe)
        end

        if platform == 'debian' || platform == 'ubuntu'
          it 'includes apt::default recipe' do
            expect(chef_run).to include_recipe 'apt::default'
          end

          it 'includes motd-tail::default recipe' do
            expect(chef_run).to include_recipe 'motd-tail::default'
          end

          it 'create motd_tail resource' do
            expect(chef_run).to create_motd_tail('/etc/motd.tail')
          end

          it 'does not include the yum-epel::default recipe' do
            expect(chef_run).to_not include_recipe 'yum-epel::default'
          end
        else
          it 'does not include the apt::default recipe' do
            expect(chef_run).to_not include_recipe 'apt::default'
          end

          it 'does not include the motd-tail::default recipe' do
            expect(chef_run).to_not include_recipe 'motd-tail::default'
          end
        end

        if platform == 'centos'
          it 'includes yum-centos::default recipe' do
            expect(chef_run).to include_recipe 'yum-centos::default'
          end

          it 'includes yum-epel::default recipe' do
            expect(chef_run).to include_recipe 'yum-epel::default'
          end
        else
          it 'does not include the yum-centos::default recipe' do
            expect(chef_run).to_not include_recipe 'yum-centos::default'
          end
        end
      end
    end
  end
end
