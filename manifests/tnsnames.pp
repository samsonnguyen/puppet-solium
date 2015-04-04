# install tnsnames.ora
class solium::tnsnames($version = undef,
                        $host    = undef) {
  validate_string($version,
                  $host)

  package { 'tnsnames':
    ensure   => 'installed',
    provider => 'pkgdmg',
    source   => "${host}/tnsnames-${version}.pkg"
  }

  file { '/etc/tnsnames.ora':
    ensure   => 'file',
    mode     => '0644',
    require  => Package['tnsnames'],
  }
}
