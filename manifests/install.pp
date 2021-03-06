class redishappy::install {

  if $redishappy::haproxy {
    package {'redishappy-haproxy':
      ensure   => present,
    }
  } else {
    package {'redishappy-haproxy':
      ensure   => absent,
    }
  }

  if $redishappy::consul {
    package {'redishappy-consul':
      ensure   => present,
    }
  } else {
    package {'redishappy-consul':
      ensure   => absent,
    }
  }

}
