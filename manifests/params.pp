# == Class: redishappy
#
# Default parameters
#
class redishappy::params {

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
  $haproxy_binary     = 'haproxy'
  $haproxy_pidfile    = '/var/run/haproxy.pid'
  $template_path      = '/etc/redishappy-haproxy/haproxy_template.cfg'
  $output_path        = '/etc/haproxy/haproxy.cfg'
  $reload_command     = "$haproxy_binary -f $output_path -p $haproxy_pidfile -sf $(cat $haproxy_pidfile)"

}