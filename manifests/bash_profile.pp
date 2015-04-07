# Copy Solium bash profile setup
class solium::bash_profile( $user  = undef,
                            $group = undef,
                            $home  = undef ) {
  validate_string($home,
                  $user,
                  $group)

  file { "${home}/.solium_profile":
    owner   => $user,
    group   => $group,
    content => template('solium/bash_profile/solium_profile.erb'),
  }

  file_line { 'source_solium_profile':
    path    => "${home}/.bash_profile",
    line    => "source ${home}/.solium_profile",
    require => File["${home}/.solium_profile"],
  }

}
