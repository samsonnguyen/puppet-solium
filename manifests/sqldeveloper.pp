# Install sqldeveloper
class solium::sqldeveloper( $version = '4.0.3.16.84',
                            $host    = undef) {
  validate_string($host,
                  $version)

  package { 'sqldeveloper':
    ensure   => present,
    flavor   => 'zip',
    provider => 'compressed_app',
    source   => "${host}/sqldeveloper-${version}-macosx.app.zip"
  }
}
