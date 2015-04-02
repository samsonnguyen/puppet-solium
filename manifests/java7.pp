# Installs java7
class solium::java7 ($source = undef) {
  validate_string($source)

  package { 'Java 7' :
    ensure   => 'installed',
    source   => $source,
    provider => 'pkgdmg',
  }

  exec { 'Add Java 7 into Jenv':
    command   => 'jenv add `/usr/libexec/java_home -version 1.7`',
    subscribe => Package['Java 7'],
    require   => [ Class['jenv'],Package['Java 7'] ],
    unless    => 'jenv versions | grep "1.7"'
  }
}
