default[:warden][:rvm_version] = 'ruby-1.9.3-p194'
default[:warden][:git_repo] = 'git://github.com/cloudfoundry/warden.git'
default[:warden][:git_branch] = 'master'

default[:warden][:root] = '/opt/warden'
default[:warden][:data] = '/var/warden'
default[:warden][:config_file] = '/etc/warden/container.yml'

default[:warden][:script][:run] = '/usr/sbin/warden-run'
default[:warden][:script][:setup] = '/usr/sbin/warden-setup'
default[:warden][:script][:purge] = '/usr/sbin/warden-purge'
default[:warden][:script][:repl] = '/usr/sbin/warden-repl'
default[:warden][:script][:server] = '/usr/sbin/warden-server'


# container config file settings

default[:warden][:config][:container_klass] = 'Warden::Container::Linux'

# Wait this long before destroying a container, after the last client
# referencing it disconnected. The timer is cancelled when during this
# period, another client references the container.
#
# Clients can be forced to specify this setting by setting the
# server-wide variable to an invalid value:
#   container_grace_time: invalid
#
# The grace time can be disabled by setting it to nil:
#   container_grace_time: ~
#
default[:warden][:config][:container_grace_time] = '300'
default[:warden][:config][:unix_domain_permissions] = '0777'

# See getrlimit(2) for details. Integer values are passed verbatim.
default[:warden][:config][:container_rlimits][:as] = '4294967296'
default[:warden][:config][:container_rlimits][:nofile] = '8192'
default[:warden][:config][:container_rlimits][:nproc] = '512'

default[:warden][:config][:quota][:disk_quota_enabled] = 'true'

default[:warden][:config][:health_check_server][:port] = '2345'
default[:warden][:config][:logging][:level] = 'debug2'

# Use this /30 network as offset for the network pool.
default[:warden][:config][:network][:pool_start_address] = '10.254.0.0'

# Pool this many /30 networks.
default[:warden][:config][:network][:pool_size] = '256'

default[:warden][:config][:user][:pool_start_uid] = '10000'
default[:warden][:config][:user][:pool_size] = '256'
