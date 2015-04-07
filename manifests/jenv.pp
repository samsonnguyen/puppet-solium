## Installs jenv and set's up various components
class solium::jenv( $user = undef,
                    $home = undef) {

  validate_string($user,
                  $home)

  package { 'jenv':
    ensure  => installed,
  }

  exec { 'install jenv ant plugin':
    command => 'jenv sh-enable-plugin ant',
    user    => $user,
    creates => "${home}/.jenv/shims/ant",
    require => Package['jenv']
  }

}
