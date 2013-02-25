#
# Cookbook Name:: warden
# Recipe:: default
#
# Copyright 2013, Troy Howard
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
%w[ build-essential debootstrap libnl1 quota ].each do |pkg|
  package pkg
end

include_recipe 'rvm::system'

#rvm_default_ruby node[:warden][:rvm_version]

rvm_ruby node[:warden][:rvm_version] do
   action :install
end

template "warden_run" do
  path node[:warden][:script][:run]
  source "run.erb"
  mode 0755
  owner 'root'
  group 'root'
end

template "warden_setup" do
  path node[:warden][:script][:setup]
  source "setup.erb"
  mode 0755
  owner 'root'
  group 'root'
  only_if { File.exist?(node[:warden][:script][:run]) }
end

template "warden_reset" do
  path node[:warden][:script][:reset]
  source "reset.erb"
  mode 0755
  owner 'root'
  group 'root'
  only_if { File.exist?(node[:warden][:script][:run]) }
end

template "warden_server" do
  path node[:warden][:script][:server]
  source "server.erb"
  mode 0755
  owner 'root'
  group 'root'
  only_if { File.exist?(node[:warden][:script][:run]) }
end

template "warden_repl" do
  path node[:warden][:script][:repl]
  source "repl.erb"
  mode 0755
  owner 'root'
  group 'root'
  only_if { File.exist?(node[:warden][:script][:run]) }
end

log "*** Warden Setup operation may take a long time to complete. ***"

execute 'warden_setup' do
  command 'warden-setup'
  only_if { File.exist?(node[:warden][:script][:setup]) }
  not_if { File.directory?(File.join(node[:warden][:root], '.git'))}
end

template "warden_service" do  
  path File.join("", "etc", "init.d", "warden")
  source "initd_service.erb"
  owner 'root'
  group 'root'
  mode 0700
end

log "*** Warden service must be manually started with 'sudo service warden start' ***"
