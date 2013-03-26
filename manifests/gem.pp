define ruby::gem($ruby, $gemset) {
  include Ruby

  $env = "cd $(/usr/bin/mktemp -dt tmp); echo ${gemset} > .rbenv-gemsets"
  exec { "Installing Gem '${name}' into Ruby Gemset ${version}@${gemset}":
    command     => "${env} && /usr/local/var/rbenv/shims/gem install ${name}",
    unless      => "${env} && /usr/local/var/rbenv/shims/gem list -i ${name}",
    path        => "/usr/local/bin:/usr/bin:/bin",
    environment => ['RBENV_ROOT=/usr/local/var/rbenv', "RBENV_VERSION=${ruby}"],
    require     => [Package['rbenv'], Package['rbenv-gemset']],
    notify      => [Exec['rbenv rehash']],
  }
}
