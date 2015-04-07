# Puppet-solium #
## What is it? ##
For use with boxen/puppet. This puppet module will boostrap a new OSX install to get a working LIVE-team environment.

Installs the following applications:

- jenv
- java6
- java7
- iterm2
- hipchat
- ant
- vagrant
- shareworks (threee branches)
- weblogic
- intellij
- sqldeveloper
- bash-completion
- tnsnames
- updates bash_profile

## Developing ##
You can develop without checking in code if you place this repository into:  

    ${HOME}/src/boxen/puppet-solium

Then change the Puppetfile on solium-boxen.  
Add this line:

    dev "solium"

And comment out:

    mod 'puppetlabs-solium',
      :git => "https://github.com/samsonnguyen/puppet-solium.git"

Make your changes in a new branch. Try to make use of classes when possible. eg. solium::[[thing here]].  

Add Specs, and update the README.md.

Finally run:

    /script/cibuild

If cibuild returns cleanly, you can push into a branch and submit a pull request.

