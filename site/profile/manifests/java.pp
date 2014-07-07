class profile::java {
  anchor { 'profile::java::begin': } ->
    class { '::java': } ->
      anchor { 'profile::java::end': }
}