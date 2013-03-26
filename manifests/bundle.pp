define ruby::bundle($gemfile = $title, $gemset, $ruby) {
  include Ruby

  ruby::version { "${ruby}": version => $ruby }

  ruby::gemset { "${gemset}": ruby => $ruby, bundler => true }

  $env = "cd $(/usr/bin/mktemp -dt tmp); echo ${gemset} > .rbenv-gemsets"
  exec { "Install gems from ${gemfile} into gemset ${ruby}@${gemset}":
    command     => "${env}; rbenv exec bundle install --gemfile '${gemfile}'",
    unless      => "${env}; rbenv exec bundle check --gemfile '${gemfile}'",
    path        => "/usr/local/bin:/usr/bin:/bin",
    environment => ["RBENV_VERSION=${ruby}"],
    notify      => [Exec['rbenv rehash']],
  }
}
