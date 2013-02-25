name             "warden"
maintainer       "Troy Howard"
maintainer_email "thoward37@gmail.com"
license          "Apache 2.0"
description      "Installs Cloud Foundry's Warden as a standalone component."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "build-essential"
depends "rvm"
depends "debootstrap"