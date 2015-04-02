# Installs java6
class solium::java6 ($source = undef) {
  validate_string($source)

  package { 'Java 6' :
    ensure   => 'installed',
    source   => $source,
    provider => 'pkgdmg',
  }

  exec { 'Add Java 6 into Jenv':
    command   => 'jenv add `/usr/libexec/java_home -version 1.6`',
    subscribe => Package['Java 6'],
    require   => [ Class['jenv'],Package['Java 6'] ],
    unless    => 'jenv versions | grep "1.6"'
  }

}
