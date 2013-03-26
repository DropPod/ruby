# Providing a basic framework for developing Ruby applications and libraries.
# The choice to use rbenv by default is a tradeoff between a simplicity and
# automatic behavior.
class ruby {
  include baseline::types

  package { 'rbenv':
    ensure   => installed,
    provider => 'homebrew';
  }

  package { 'rbenv-gemset':
    ensure   => installed,
    provider => 'homebrew';
  }

  package { 'ruby-build':
    ensure   => installed,
    provider => 'homebrew';
  }

  rcfile { 'rbenv':
    source => "puppet:///modules/ruby/rbenv.sh",
  }

  exec { 'rbenv rehash':
    path        => "/usr/local/bin:/usr/bin:/bin",
    environment => ['RBENV_ROOT=/usr/local/var/rbenv'],
    refreshonly => true,
  }
}
