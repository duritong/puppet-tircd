# manage a tircd installation
# on debian
class tircd(
  $port = 16667,
) {
  package{'tircd':
    ensure => installed,
  } -> file{'/etc/default/tircd':
    content => "ENABLED=1
export HTTPS_CA_DIR=/usr/share/ca-certificates/
",
    notify  => Service['tircd'],
    owner   => root,
    group   => 0,
    mode    => '0644';
  } -> file_line{
    'enable_ssl_on_tircd':
      path  => '/etc/tircd.cfg',
      line  => 'use_ssl 1',
      match => '^use_ssl';
    'tircd_port':
      path  => '/etc/tircd.cfg',
      line  => "port ${port}"
      match => '^port',
  } ~> service{'tircd':
    ensure => running,
    enable => true,
  }

}
