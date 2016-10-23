execute 'apt-get update' do
  command 'apt-get update'
end

package 'nginx' do
  action :install
end

service 'nginx' do
  action [:start, :enable]
end

bash 'set nginx to start automatically whenever server reboots' do
  cwd '/home/ubuntu'
  code <<-EOH
    update-rc.d nginx defaults
    EOH
  action :run
end

template '/etc/nginx/sites-available/' do
  source 'default'
  owner 'ubuntu'
  mode '0700'
end

