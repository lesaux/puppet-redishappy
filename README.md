puppet-redishappy
=================

A puppet module to manage redishappy

Supports configuration for haproxy and consul.

redishappy seems to only support one cluster of sentinels atm. You'll need to have all of your monitors in one single sentinel.

Haproxy / consul installation and services should probably be managed by another module.

The repo.pp class configures the repo that holds the redishappy deb/rpm packages, managed by the redishappy developers. If there are issues with setting up and connecting to this repo, it is suggested to build redishappy and manage the packages in your own repository (or locally). The default for $use_developers_repo variable is therefore currently set to false.

When using consul, please be aware of the following two things:

1) The redishappy-consul application uses the consul catalog/register API to update consul through an agent. The implication of this is that if you try to register a service to an existing node (i.e. a nodename that appears under nodes in the consul ui), then the agent of that node will automatically deregister it when it performs anti-entropy (usually within a minute), which is undesirable and can be very confusing. For this reason please use a non-registered node name for your service.

2) The consul config cluster property within a service hash must match the name for a cluster, as set in the main part of the configuration. They both must ALSO match a sentinel cluster name, otherwise the consul go flipper client will fail to update consul properly.

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

In CentOS 7, there may be issues with the service init script, which is contained in the redishappy-consul rpm. More specifically, the init script will hang when attempting to start the service. If you come across this issue, a way to quickly overcome it will be to use systemd instead, for example adding a service file under /etc/systemd/system/ with the following contents:

```
[Unit]
Description=Daemon for redishappy-consul

[Service]
Type=simple
ExecStart=/usr/bin/redis-consul -config /etc/redishappy-consul/config.json -log /var/log/redishappy-consul

[Install]
WantedBy=multi-user.target
```

You can add a file resource eg. within your profile (notifying the redishappy::service class would also be a good idea) and then simply pass that service name as the value to the consul_service variable of the redishappy module main class.