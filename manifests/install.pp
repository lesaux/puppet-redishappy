class redishappy::install {

  if $redishappy::haproxy {
    package {'redishappy-haproxy':
      ensure   => present,
    }
  }

  if $redishappy::consul {
    package {'redishappy-consul':
      ensure   => present,
    }
  }

}
