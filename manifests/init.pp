# This is a placeholder class.
class solium(
    $user      = $::boxen_user,
    $password  = undef,
    $branches  = undef,
    $group     = 'staff',
    $files_url = 'http://sharkcage.solium.com/vagrant-files/',
    $svn_host  = 'https://svn.solium.com/svn/shareworks/branches/',
  ) {
  include boxen::config
  require homebrew
  include java6
  include java7
  include jenv

  ## homebrew packages
  $homebrew_packages = [ 'coreutils','renameutils' ]
  package { $homebrew_packages:
    ensure => 'installed'
  }

  $home = "/Users/${user}"

  class { 'solium::weblogic':
    version     => '10.3.6.0.6',
    url         => "${files_url}/wls1036_dev_w_nativeio.zip",
    install_dir => '/opt/java/oracle/weblogic/',
  }

  $default_branches = [ { 'name'      => 'solium-branch1',
                          'sw_branch' => 'shareworks-5_22_br' },
                        { 'name'      => 'solium-branch2',
                          'sw_branch' => 'shareworks-5_23_br' },
                        { 'name'      => 'solium-branch3',
                          'sw_branch' => 'shareworks-5_24_br' } ]
  $real_branches = $branches? {
    undef   => $default_branches,
    default => $branches
  }

  class { 'solium::shareworks':
    user     => $user,
    group    => $group,
    password => $password,
    host     => $svn_host,
    branches => $real_branches,
    home     => $home
  }

  class { 'solium::sqldeveloper':
    version  => '4.0.3.16.84',
    host     => $files_url
  }

  class { 'solium::bashcompletion': }
  class { 'solium::tnsnames':
    version  => '0.0.1',
    host     => $files_url,
  }

  ## Define ordering here
  Class['java6']
  -> Class['java7']
  -> Class['jenv']
  -> Class['solium::weblogic']
  -> Class['solium::shareworks']
  #-> Class['solium::bash_profile']
}
