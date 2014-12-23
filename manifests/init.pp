class redishappy (

  $haproxy          = false,
  $consul           = false, #support not implemented yet
  $clusters         = $redishappy::params::clusters,
  $sentinels        = $redishappy::params::sentinels,
  $haproxy_binary   = $redishappy::params::haproxy_binary,
  $haproxy_pidfile  = $redishappy::params::haproxy_pidfile,
  $template_path    = $redishappy::params::template_path,
  $output_path      = $redishappy::params::output_path,
  $reload_command   = $redishappy::params::reload_command,

) {


  if empty($clusters) {
    fail('clusters cannot be empty')
  }

  class{'redishappy::repo': } ->
  class{'redishappy::install': } ->
  class{'redishappy::params': } ->
  class{'redishappy::config': }
  #class{'redishappy::service': }

}
