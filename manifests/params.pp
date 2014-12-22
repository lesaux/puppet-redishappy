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



  $version            = '0.0.1'

}
