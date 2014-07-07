class profile::maven {
  require profile::java

  anchor { 'profile::maven::begin': } ->
    class { '::maven': } ->
      anchor { 'profile::maven::end': }
}