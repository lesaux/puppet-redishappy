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
      ensure   => $redishappy::service_ensure,
      enable   => $redishappy::service_enable,
    }
  }

  if $redishappy::consul {
    service {"$consul_service":
      ensure   => $redishappy::service_ensure,
      enable   => $redishappy::service_enable,
    }
  }

}
