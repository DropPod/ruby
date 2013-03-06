# The `ruby` Framework #

This module introduces a framework for managing [Ruby][Ruby] on developer
workstations. This includes providing tools for handling multiple versions of
Ruby, in addition to maintaining disparate sets of library dependencies.

To accomplish these goals, this framework leverages [rbenv][rbenv] and
[rbenv-gemset][rbenv-gemset], in addition to providing helpers for dealing with
installation of [Gems][rubygems].

## Example ##

``` puppet
ruby::version { '2.0.0-p0': }
ruby::gemset { "my-project": ruby => '2.0.0-p0' }
ruby::gem { "bundler": ruby => '2.0.0-p0', gemset => 'my-project' }
```

[Ruby]: http://www.ruby-lang.org
[rbenv]: https://github.com/sstephenson/rbenv
[rbenv-gemset]: https://github.com/jamis/rbenv-gemset
[rubygems]: http://rubygems.org
