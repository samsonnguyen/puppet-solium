# Installs bash-completion
class solium::bashcompletion {

  package { 'bash-completion':
    ensure      => latest
  }

}
