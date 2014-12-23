
class redishappy::config {

  if $redishappy::haproxy {
    file { '/etc/redishappy-haproxy/config.json':
      ensure  => present,
      content => template('redishappy/config.json.erb'),
      notify  => service("$::redishappy::service::haproxy-service"),
    }
    file { "$::redishappy::params::template_path":
      ensure  => present,
      content => template('redishappy/haproxy_template.cfg.erb'),
      notify  => service("$::redishappy::service::haproxy-service"),
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
  }

}
