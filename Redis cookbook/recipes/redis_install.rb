execute 'apt-get update' do
  comand 'apt-get update'
end

package ['build-essential', 'tcl8.5', 'make'] do
  action :install
end

remote_file "#{redis_file_location}" do
  source "#{redis_url}"
  owner 'ubuntu'
  mode '0700'
  action :create
end

bash 'extract redis' do
  cwd "#{redis_file_location}"
  code <<-EOH
    tar -xvf #{redis_filename}
    cd redis-stable
    make && make install
    cd utils
    ./install_server.sh
    EOH
  action :run
end

template '/etc/redis/redis.conf' do
  source 'redis.conf'
  mode '0700'
  owner 'ubuntu'
end