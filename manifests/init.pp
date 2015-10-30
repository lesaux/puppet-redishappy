class redishappy (

  $haproxy             = false,
  $consul              = false,
  $clusters            = $redishappy::params::clusters,
  $sentinels           = $redishappy::params::sentinels,
  $haproxy_binary      = $redishappy::params::haproxy_binary,
  $haproxy_pidfile     = $redishappy::params::haproxy_pidfile,
  $template_path       = $redishappy::params::template_path,
  $output_path         = $redishappy::params::output_path,
  $consul_config       = {},
  $service_ensure      = $redishappy::params::service_ensure,
  $service_enable      = $redishappy::params::service_enable,
  $use_developers_repo = false,

) {

  if empty($clusters) {
    fail('clusters cannot be empty')
  }
  anchor {'redishappy::begin': } ->
  class {'redishappy::params': } ->
  class {'redishappy::repo': } ->
  class {'redishappy::install': } ->
  class {'redishappy::config': } ->
  class {'redishappy::service':} ->
  anchor {'redishappy::end': }

}
