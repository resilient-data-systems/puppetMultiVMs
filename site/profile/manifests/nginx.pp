class profile::nginx {

  anchor { 'profile::nginx::begin': } ->
    class { '::nginx':
      worker_processes   => $::processorcount,
      worker_connections => 10240,
      proxy_buffers      => '32 8k',
      proxy_buffer_size  => '8k',
    } ->
      anchor { 'profile::nginx::end': }
}