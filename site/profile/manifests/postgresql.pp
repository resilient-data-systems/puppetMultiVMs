class profile::postgresql {
  anchor { 'profile::postgresql::begin': } ->
    class { '::postgresql::globals': 
      manage_package_repo => true,
      version             => '9.3',
    } ->
      class { '::postgresql::server': 
      listen_addresses           => '*',
      ipv4acls                   => [
                               'local      sonar            sonar  md5', 
                               'host       sonar            sonar  127.0.1.1/32         md5'],
      } ->
        anchor { 'profile::postgresql::end': }
}
