# This is a placeholder class.
class solium(
    $user      = $::boxen_user,
    $password  = undef,
    $branches  = undef,
    $group     = 'staff',
    $files_url = 'http://sharkcage.solium.com/vagrant-files',
    $svn_host  = 'https://svn.solium.com/svn/shareworks/branches/',
  ) {
  include boxen::config
  require homebrew
  include java7
  include jenv
  include git
  include iterm2::dev
  include iterm2::colors::solarized_dark
  include hipchat
  include ant
  include vagrant
  include virtualbox

  ## Variables
  $home = "/Users/${user}"
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

  ## Homebrew packages
  $homebrew_packages = [ 'coreutils','renameutils' ]
  package { $homebrew_packages:
    ensure => 'installed'
  }

  ## Vagrant plugins
  vagrant::plugin { 'berkshelf': } # Resolves to vagrant-berkshelf
  vagrant::plugin { 'omnibus': }

  class { 'solium::java6':
    source => "${files_url}/JavaForOSX2014-001.dmg"
  }

  class { 'solium::weblogic':
    version     => '10.3.6.0.6',
    url         => "${files_url}/wls1036_dev_w_nativeio.zip",
    install_dir => '/opt/java/oracle/weblogic/',
  }

  class { 'intellij':
    edition => 'ultimate',
    version => '14.1'
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

  exec { 'jenv-ant':
    command => 'jenv enable-plugin ant',
    unless  => "test -e /Users/${user}/.jenv/shims/ant",
  }

  ## Define strict dependency ordering here
  Class['jenv']
  -> Class['solium::java6']
  -> Class['solium::java7']

  Class['jenv']
  -> Package['ant']
}
