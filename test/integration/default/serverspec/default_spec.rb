# Encoding: utf-8

require_relative 'spec_helper'

case os[:family]
when 'redhat'
  describe file('/etc/yum/vars/osname') do
    its(:content) { should match(/(fedora|centos|redhat|amazon)/) }
  end

  describe file('/etc/motd') do
    it { should exist }
  end
when 'ubuntu'
  describe file('/etc/motd.tail') do
    it { should exist }
  end
end
