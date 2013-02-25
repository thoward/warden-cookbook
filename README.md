warden-cookbook
===============

A cookbook to install Cloud Foundry's Warden as a standalone component.

## Locations and Files

By default, this cookbook creates file in the following locations (though most can be overriden via node attributes).

### Warden Installation Directory

```
/opt/warden
```

This contains the source files from the git repository for Warden. The repo and branch can be overriden with ```node[:warden][:git_repo]``` and ```node[:warden][:git_branch]``` if you wish to use a fork or a branch. By default it clones http://github.com/cloudfoundry/warden and uses the ```master``` branch.

The location of this directory can be overridden in ```node[:warden][:root]```.

### Configuration File

```
/etc/warden/container.yml
```

The location of this file may be overridden with ```node[:warden][:config_file]```.


### Data Directory

```
/var/warden
```

This directory holds the rootfs and container data. The location of this file may be overridden with ```node[:warden][:data]```.


### Init.d script
```
/etc/init.d/warden
```

A init.d script which allows basic service interactions eg:

```
sudo service warden start
sudo service warden stop
sudo service warden restart
```

On start, this writes a PID file for the process to ```/var/run/warden.pid```. Neither the location of this script, it's PID file or the log file can be overridden with attributes at this time.

### Log File

```
/var/log/warden.log
```

### PID File

```
/var/run/warden.pid
```

### General Scripts

NOTE: These scripts must all be run as **root**.

#### warden-setup

```
/usr/sbin/warden-setup
```

This script installs and updates warden. 

This will: 
- Clone or update the warden code from github
- Run ```bundle install```
- Run ```rake setup``` which will build the chroot rootfs


#### warden-repl

```
/usr/sbin/warden-repl
```

This script runs an interactive REPL console for warden. 


#### warden-run

```
/usr/sbin/warden-run
```

This script executes commands in warden's directory/rvm/bundle context. This isn't really meant for manual usage, but is a utility script used by the other scripts.


#### warden-purge

```
/usr/sbin/warden-purge
```

This script deletes the warden root directory. It's just a shortcut for ```rm -rf /opt/warden``` and is generally followed by ```sudo warden-setup``` to reinstall warden. Note: Since data is stored in a different directory, this only purges the warden server code and it's container template.


## Credit / History

This cookbook was originally a port of [vagrant-warden](https://github.com/silas/vagrant-warden) by @silas . The original vagrant project uses Puppet for the provisioner, but I felt more comfortable w/ Chef so I ported it. 
