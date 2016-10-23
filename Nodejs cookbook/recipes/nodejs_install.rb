execute 'apt-get update' do
  command 'apt-get update'
end

package ['npm', 'nodejs'] do
  action :install
end

bash 'create a folder-testapp and should paste your test_application.js here' do
  cwd "#{cwd}"
  code <<-EOH
    mkdir testapp
    cd testapp
    EOH
end

cookbook_file '/home/ubuntu/testapp' do
  source 'test_application'
  owner 'ubuntu'
  mode '0700'
  action :create
end

include_recipe 'nginx::nginx_install'

bash 'start the nodejs application' do
  cwd "#{cwd}"
  code <<-EOH
    nodejs testapp/test_application.js
    EOH
end


