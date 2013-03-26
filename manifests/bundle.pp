define ruby::bundle($gemfile = $title, $gemset, $ruby) {
  include Ruby

  ruby::version { "${ruby}": version => $ruby }

  ruby::gemset { "${gemset}": ruby => $ruby }

  ruby::gem { "bundler": ruby => $ruby, gemset => $gemset }

  $env = "cd $(/usr/bin/mktemp -dt tmp); echo ${gemset} > .rbenv-gemsets"
  exec { "Install gems from ${gemfile} into gemset ${ruby}@${gemset}":
    command     => "${env}; rbenv exec bundle install --gemfile '${gemfile}'",
    unless      => "${env}; rbenv rehash; rbenv exec bundle check --gemfile '${gemfile}'",
    path        => "/usr/local/bin:/usr/bin:/bin",
    environment => ['RBENV_ROOT=/usr/local/var/rbenv', "RBENV_VERSION=${ruby}"],
    require     => [Ruby::Gem['bundler']],
    notify      => [Exec['rbenv rehash']],
  }
}
