define ruby::gemset($ruby, $bundler=true) {
  include Ruby

  $awk = "/usr/bin/awk '{ if (\$0 ~ /^[^ ]/) ver = \$1; else print ver \$1 }'"
  exec { "Creating Ruby Gemset ${ruby}@${name}":
    command     => "/usr/local/bin/rbenv gemset create ${ruby} ${name}",
    unless      => "/usr/local/bin/rbenv gemset list | ${awk} | grep ${ruby}:${name}",
    environment => ['RBENV_ROOT=/usr/local/var/rbenv'],
    require     => [Package['rbenv'], Package['rbenv-gemset']],
  }

  Ruby::Gemset[$name] -> Ruby::Gem <| ruby == $ruby and gemset == $name |>

  if ($bundler) {
    ruby::gem { "bundler": ruby => $ruby, gemset => $name }
  }
}
