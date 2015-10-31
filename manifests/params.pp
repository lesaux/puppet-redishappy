# == Class: redishappy
#
# Default parameters
#
class redishappy::params {

  $haproxy_binary     = 'haproxy'
  $haproxy_pidfile    = '/var/run/haproxy.pid'
  $template_path      = '/etc/redishappy-haproxy/haproxy_template.cfg'
  $output_path        = '/etc/haproxy/haproxy-redishappy.cfg'
  $reload_command     = "$::redishappy::haproxy_binary -f $::redishappy::output_path -p $::redishappy::haproxy_pidfile -sf $(cat $::redishappy::haproxy_pidfile)"
  $service_ensure     = true
  $service_enable     = true

  case $::osfamily {
   'redhat': {
     $haproxy_service = 'redishappy-haproxy'
     $consul_service  = 'redishappy-consul'
   }
   'debian': {
     $haproxy_service = 'redishappy-haproxy-service'
     $consul_service  = 'redishappy-consul-service'
   }
}

  $clusters        = {
    'cluster1' => {
      'ExternalPort' => '6981',
    },
    'cluster2' => {
      'ExternalPort' => '6982',
    },
  }
  $sentinels        = {
    'cluster1' => {
      'Host'         => '127.0.0.1',
      'Port'         => '26779',
    },
    'cluster2' => {
      'Host'         => '127.0.0.1',
      'Port'         => '26780',
    },
  }

}
