class redishappy::config {

  $clusters      = $redishappy::clusters
  $sentinels     = $redishappy::sentinels
  $consul_config = $redishappy::consul_config

  if $redishappy::haproxy {
    file { '/etc/redishappy-haproxy/config.json':
      ensure  => present,
      content => template('redishappy/haproxy-config.json.erb'),
      notify  => Class['redishappy::service'],
    }
    file { "$::redishappy::params::template_path":
      ensure  => present,
      content => template('redishappy/haproxy_template.cfg.erb'),
      notify  => Class['redishappy::service'],
    }
    file { "$::redishappy::output_path":
      ensure  => present,
    }
  } else {
    file { '/etc/redishappy-haproxy/config.json':
      ensure  => absent,
    }
    file { "$redishappy::params::template_path":
      ensure  => absent,
    }
    file { "$redishappy::params::output_path":
      ensure  => absent,
    }
  }

  if $redishappy::consul {
    file { '/etc/redishappy-consul/config.json':
      ensure  => present,
      content => template('redishappy/consul-config.json.erb'),
      notify  => Class['redishappy::service'],
    }
  } else {
    file { '/etc/redishappy-consul/config.json':
      ensure  => absent,
    }
  }

}
