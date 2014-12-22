class redishappy::repo {

  case $::osfamily {
    'redhat': {
      yumrepo { 'redishappy':
        descr => 'redishappy haproxy and consul packages',
        baseurl => "http://download.linuxdataflow.org:81/rpm-repos/redishappy/el${operatingsystemmajrelease}/",
        enabled => 1,
        gpgcheck => 0,
        gpgkey => absent,
        exclude => absent,
        metadata_expire => absent,
      }
    }
    'debian': {
      include apt
      apt::source { 'redishappy':
        comment           => 'redishappy haproxy and consul packages',
        location          => 'http://download.linuxdataflow.org:81/deb-repos/redishappy/',
        release           => 'stable',
        repos             => 'main',
        required_packages => 'debian-keyring debian-archive-keyring',
        key               => '090F039D',
        key_source        => 'http://download.linuxdataflow.org:81/deb-repos/redishappy/redishappy.gpg',
        include_src       => false,
        include_deb       => true
      }
    }
  }

}
