include apt
$as_vagrant = 'sudo -u vagrant'
$home = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}
include apt::backports

# --- Stages -------------------------------------------------------------------
stage {'ruby': }
stage {'setup-apt':}
stage { 'preinstall':}
Stage['preinstall'] -> Stage['setup-apt'] -> Stage['main'] -> Stage['ruby']

# --- Preinstall Stage ---------------------------------------------------------

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}
class { 'timezone':
  timezone => 'America/Los_Angeles',
           stage => preinstall
}

class { 'locales':
  default_value  => 'en_US.UTF-8',
  stage => preinstall
}

# --- Setup Apt ----------------------------------------------------------------
class install_backports {
  apt::ppa { 'ppa:transmissionbt/ppa': }
  apt::ppa { 'ppa:rwky/redis': }
}
class {'install_backports':}

# --- Packages -----------------------------------------------------------------
package { 'llvm':
  ensure  => installed
}

package { 'nodejs':
  ensure  => installed
}

package { 'curl':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

# Nokogiri dependencies.
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}

package { 'graphviz':
  ensure => installed
}

package {'libcurl3':
  ensure => installed
}

package {'libcurl3-gnutls':
  ensure => installed
}

package {'libcurl4-openssl-dev':
  ensure => installed
}
package {'python-software-properties':
  ensure => installed
}
Apt::Ppa['ppa:transmissionbt/ppa'] ->
package {'transmission-daemon':
  ensure => installed
}
Apt::Ppa['ppa:rwky/redis'] ->
package{'redis-server':
  ensure => installed
}
# --- PostgreSQL ---------------------------------------------------------------
class install_postgres {
  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
    locale              => 'en_US.utf8',
    encoding            => 'UTF8',
  }-> class { 'postgresql::server':
    ip_mask_allow_all_users    => '0.0.0.0/0',
    ipv4acls                   => ['local all all md5'],
  }
  postgresql::server::db { 'heaven':
    user     => 'heaven',
    password => postgresql_password('heaven', 'heaven'),
    encoding => 'UTF8',
  }
  package {'libpq-dev':
    ensure => installed,
    require => Class['postgresql::server']
  }
  package { 'postgresql-contrib':
    ensure => installed,
    require => Class['postgresql::server'],
  }
}
class {'install_postgres':}

# --- Ruby ---------------------------------------------------------------------
class {'rvm':
  version => '1.25.32'
}
