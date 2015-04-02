# Installs weblogic
class solium::weblogic ($user        = undef,
                        $group       = undef,
                        $version     = undef,
                        $url         = undef,
                        $install_dir = undef) {
  include wget

  validate_string(
    $user,
    $group,
    $version,
    $url,
    $install_dir
  )

  notify { 'Downloading Weblogic. This may take a while':
    before => Exec['retrieve_weblogic'],
  }

  exec { 'retrieve_weblogic':
    command => "wget ${url} -O /tmp/wls_${version}.zip",
    creates => "/tmp/wls_${version}.zip",
    require => Package['wget'],
    unless  => "test -d ${install_dir}${version}/wlserver",
    timeout => 3600,
    user    => $user,
  }

  file { ['/opt/java',
          '/opt/java/oracle/',
          '/opt/java/oracle/weblogic/',
          "${install_dir}${version}"]:
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    mode    => '0775',
    require => Exec['retrieve_weblogic']
  }

  exec { 'install_weblogic' :
    command => "unzip -o /tmp/wls_${version}.zip -d ${install_dir}${version}",
    require => Exec['retrieve_weblogic'],
    onlyif  => "test -d ${install_dir}${version}",
    unless  => "test -d ${install_dir}${version}/wlserver",
    user    => $user,
  }

  exec { 'create_symlink' :
    command => "ln -sfn ${install_dir}${version} ${install_dir}/10.3.6",
    require => Exec['install_weblogic'],
    user    => $user
  }

}
