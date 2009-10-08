/*

== Class: tomcat::package::v5-5

Installs tomcat 5.5.X using your systems package manager.

Requires:
- java to be previously installed

Tested on:
- RHEL 5
- Debian Lenny

Usage:
  include tomcat::package::v5-5

*/
class tomcat::package::v5-5 inherits tomcat {

  $tomcat = $operatingsystem ? {
    RedHat => "tomcat5",
    Debian => "tomcat5.5",
    Ubuntu => "tomcat5.5",
  }

  include tomcat::package

  case $operatingsystem {

    RedHat: {
      file { "/usr/share/tomcat5/bin/catalina.sh":
        ensure => link,
        target => "/usr/bin/dtomcat5",
      }

      User["tomcat"] {
        require => Package["tomcat5"],
      }
    }

    default: {
      err("operating system '${operatingsystem}' not defined.")
    }
  }

}