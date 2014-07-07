class role::devopsproxy inherits role {
    class { 'profile::nginx': } 

    Nginx::Resource::Vhost {
        vhost_cfg_append       => {'ignore_invalid_headers' =>  'off',
                                   'gzip_types'             =>  'text/plain text/css application/json text/xml application/xml application/xml+rss text/javascript application/javascript',
                                   'gzip_buffers'           =>  '4  256k',
                                   'gzip_comp_level'        =>  '5', },
        location_cfg_append    => {'proxy_redirect' => 'default'},
    }

    nginx::resource::vhost { 'sonar.rds.pub':
        #private network
        proxy                  => 'http://sonar.rds.priv:9000',
    }

    nginx::resource::location { 'sonar-expires':
        ensure               => present,
        location             => '~* \.(png|jpg|jpeg|gif|ico|js|css)$',
        #private network
        proxy                => 'http://sonar.rds.priv:9000',
        #external host
        vhost                => 'sonar.rds.pub',
        location_cfg_prepend => {'expires' => '1y'},
    }
}