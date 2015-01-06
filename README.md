puppet-redishappy-haproxy
=========================

A puppet module to manage redishappy

Only haproxy support atm.

redishappy-haproxy seems to only support one cluster of sentinels atm. You'll need to have all of your monitors in one single sentinel.

example usage:

```
  class {'redishappy':
    haproxy          => true,
    haproxy_binary   => '/usr/sbin/haproxy',
    haproxy_pidfile  => '/var/run/haproxy_redis.pid',
    template_path    => '/etc/redishappy-haproxy/haproxy_template.cfg',
    output_path      => '/etc/haproxy/haproxy_redis.cfg',
    clusters         => {
      'sensu'    => {
        'ExternalPort' => '6981',
      },
      'flapjack' => {
        'ExternalPort' => '6982',
      },
    },
    sentinels        => {
      'node1'    => {
        'Host' => someip,
        'Port' => '26379',
      },
      'node2'    => {
        'Host' => anotherip,
        'Port' => '26379',
      },
      'node3'      => {
        'Host' => someotherip,
        'Port' => '26379',
      },
      'node4'      => {
        'Host' => anotherip,
        'Port' => '26379',
      },
    },

  }
  ```
