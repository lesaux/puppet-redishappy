class redishappy (

  $haproxy          = false,
  $consul           = false,
  $clusters         = $redishappy::params::clusters,
  $sentinels        = $redishappy::params::sentinels,

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
