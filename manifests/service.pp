class redishappy::service {

  if $redishappy::haproxy {
    service {"$redishappy::haproxy_service":
      ensure   => $redishappy::service_ensure,
      enable   => $redishappy::service_enable,
    }
  }

  if $redishappy::consul {
    service {"$redishappy::consul_service":
      ensure   => $redishappy::service_ensure,
      enable   => $redishappy::service_enable,
    }
  }

}
