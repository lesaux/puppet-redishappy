
class redishappy::config {

  file { '/etc/redishappy-haproxy/config.json':
    ensure  => present,
    content => template('redishappy/config.json.erb'),
  }


}
