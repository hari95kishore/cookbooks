bash 'import key and create a list file' do
  cwd "#{cwd}"
  code <<-EOH 
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
    apt-get update
    EOH
end

package 'mongodb-org' do
  action :install
end

bash 'enter mongodb shell and create a DB sampleapp' do
  cwd "#{cwd}"
  code <<-EOH
    mongo
    use sampleapp
    exit
  EOH
end