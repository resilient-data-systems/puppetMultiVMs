class profile::sonarqube {
  require profile::maven
  require profile::postgresql

  $jdbc = {
    url               => 'jdbc:postgresql://localhost/sonar',
    username          => 'sonar',
    password          => 'AfAz37my0apr',
  }
  
  anchor { 'profile::sonarqube::begin': } ->
    postgresql::server::db { 'sonar':
    user     => 'sonar',
    password => postgresql_password('sonar', 'AfAz37my0apr'),
  } ->
    class { '::sonarqube' :
      arch         => 'linux-x86-64',
      version      => '4.3',
      user         => 'sonar',
      group        => 'sonar',
      service      => 'sonar',
      installroot  => '/usr/local',
      home         => '/var/local/sonar',
      download_url => 'http://dist.sonar.codehaus.org',
      jdbc         => $jdbc,
      log_folder   => '/var/local/sonar/logs',
    } ->
               anchor { 'profile::sonarqube::end': }
}