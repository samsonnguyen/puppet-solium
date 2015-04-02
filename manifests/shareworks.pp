# You must pass in the password variable via hiera. See https://github.com/TomPoulton/hiera-eyaml
# Example:
#  /opt/boxen/repo/hiera/users/samsonnguyen.eyaml

class solium::shareworks( $user     = undef,
                          $group    = undef,
                          $password = undef,
                          $host     = undef,
                          $home     = undef,
                          $branches = undef) {
  include wget

  validate_string($user,
                  $group,
                  $password,
                  $host)

  file {[  "${home}/dev",
            "${home}/dev/${branches[0]['name']}",
            "${home}/dev/${branches[1]['name']}",
            "${home}/dev/${branches[2]['name']}",
            "${home}/dev/${branches[0]['name']}/solium",
            "${home}/dev/${branches[1]['name']}/solium",
            "${home}/dev/${branches[2]['name']}/solium"
        ]:
    ensure       => directory,
    owner        => $user,
    group        => $group,
    recurse      => true,
  }

  vcsrepo {
    "${home}/dev/${branches[0]['name']}/solium":
      ensure              => present,
      provider            => svn,
      basic_auth_username => $user,
      user                => $user,
      basic_auth_password => $password,
      source              => "${host}/${branches[0]['sw_branch']}";
    "${home}/dev/${branches[1]['name']}/solium":
      ensure              => present,
      provider            => svn,
      basic_auth_username => $user,
      user                => $user,
      basic_auth_password => $password,
      source              => "${host}/${branches[1]['sw_branch']}";
    "${home}/dev/${branches[2]['name']}/solium":
      ensure              => present,
      provider            => svn,
      basic_auth_username => $user,
      user                => $user,
      basic_auth_password => $password,
      source              => "${host}/${branches[2]['sw_branch']}";
  }
}
