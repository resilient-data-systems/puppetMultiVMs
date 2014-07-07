# The filebucket allows for file backups to the server
filebucket { main: server => "puppet" }

# Set global defaults - including backing up all files to the main filebucket and adds a global path
File { backup => main }
Exec { path => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin" }

# Purge any unmanaged firewall resources
resources { "firewall":
  purge => true
}

# Setup default firewall rule ordering
Firewall {
  before  => Class['profile::firewall::post'],
  require => Class['profile::firewall::pre'],
}

# Load in all of our nodes
import "nodes"