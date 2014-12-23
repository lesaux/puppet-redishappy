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
}

  if $redishappy::haproxy {
    service {"$haproxy_service":
      ensure   => running,
      enable   => true,
    }
  }

  if $redishappy::consul {
    service {"$consul_service":
      ensure   => running,
      enable   => true,
    }
  }

}
