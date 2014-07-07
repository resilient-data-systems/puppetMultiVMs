class role::sonar inherits role {
  class { 'profile::postgresql': }
  class { 'profile::sonarqube': }

}