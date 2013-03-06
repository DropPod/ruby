# A type for managing the installation of a particular version of Ruby.
define ruby::version($version = $title) {
  include ruby

  exec { "Building Ruby ${version}":
    command     => "/usr/local/bin/rbenv install ${version}",
    unless      => "/usr/local/bin/rbenv versions | grep ${version}",
    environment => ['RBENV_ROOT=/usr/local/var/rbenv'],
    timeout     => 0,
    require     => [Package['rbenv'], Package['ruby-build']],
  }

  Ruby::Version[$name] -> Ruby::Gemset <| version == $version |>
}
