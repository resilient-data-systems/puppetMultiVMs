# Default (unconfigured) node should only receive base profile
node default {
  include role
}

###########################
## Vagrant test VMs      ##
###########################
# Vagrant devopsproxy
node 'devopsproxy.rds.priv' {
  include role::devopsproxy
}

# Vagrant sonar
node 'sonar.rds.priv' {
  include role::sonar
}