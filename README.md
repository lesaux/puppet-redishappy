puppet-redishappy
=================

A puppet module to manage redishappy

Supports configuration for haproxy and consul.

redishappy seems to only support one cluster of sentinels atm. You'll need to have all of your monitors in one single sentinel.

The haproxy / consul should probably be managed by another module.

The repo.pp class configures the repo that holds the redishappy deb/rpm packages, managed by the redishappy developers. If there are issues with setting up and connecting to this repo, it is suggested to build redishappy and manage the packages in your own repository (or locally). The default for $use_developers_repo variable is therefore currently set to false.

When using consul, please be aware of the following two things:

1) The redishappy-consul application uses the consul catalog/register API to update consul through an agent. The implication of this is that if you try to register a service to an existing node (i.e. a nodename that appears under nodes in the consul ui), then the agent of that node will automatically deregister it when it performs anti-entropy. For this reason please use a non-registered node name.

2) The consul config cluster property within a service hash must match the name for a cluster, as set in the main part of the configuration. They both MUST also match a sentinel cluster name, otherwise the consul flipper client will fail to update consul properly.

example usage for haproxy:

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

example usage for consul (currently supports a single service):

```
  class {'redishappy':
    consul           => true,
    clusters         => {
      'sensu'    => {
        'ExternalPort' => '6981',
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
    },
    consul_config        => {
      'Address'    => '127.0.0.1:8500',
      'Services'   => {
        'Cluster'    => 'sensu',
        'Node'       => 'redis-master-node',
        'Datacenter' => 'dc1',
        'tags'       => '"redis", "master',
      },
    },

  }
  ```
