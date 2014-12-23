class redishappy::service {

case $::osfamily {
   'redhat': {
     $haproxy_service = 'redishappy-haproxy'
     $consul_service  = 'redishappy-consul'
   }
   'debian': {
     $haproxy_service = 'redishappy-haproxy-service'
     $consul_service  = 'redishappy-consul-service'
   }
   default: {
     # ...
   }
}

  if $redishappy::haproxy {
    service {"$haproxy_service":
      ensure   => enabled,
    }
  } else {
    service {"$haproxy_service":
      ensure   => disabled,
    }
  }

  if $redishappy::consul {
    service {"$consul_service":
      ensure   => enabled,
    }
  } else {
    package {"$consul_service":
      ensure   => disabled,
    }
  }

}

