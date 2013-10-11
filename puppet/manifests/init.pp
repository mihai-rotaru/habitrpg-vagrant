exec { 'update_apt':
  command => 'apt-get update',
  path => '/usr/bin'
}

class { 'git':
  require => Exec['update_apt']
}

class { 'nodejs':
  version => 'v0.8.25',
}

package { 'grunt-cli':
  ensure => 'present',
  provider => 'npm',
  require => Class['nodejs']
}

vcsrepo { "/srv/habit-rpg":
  ensure => latest,
  provider => git,
  source => 'https://github.com/lefnire/habitrpg.git',
  revision => 'develop',
  owner => 'vagrant',
  group => 'vagrant',
  require => [Class['nodejs'],Class['git']]
}

file { "/srv/habit-rpg/config.json":
  owner => vagrant,
  group => vagrant,
  mode => 550,
  source => "/srv/habit-rpg/config.json.example",
  require => Vcsrepo['/srv/habit-rpg']
}

exec { 'install_npm_dependencies':
  command => 'npm install',
  cwd => '/srv/habit-rpg',
  path => '/usr/bin:/usr/local/bin',
  require => File['/srv/habit-rpg/config.json']
}

exec { 'run_habitrpg':
  command => 'grunt run:dev',
  cwd => '/srv/habit-rpg',
  path => '/usr/bin:/usr/local/bin',
  require => [ Exec['install_npm_dependencies'], Package['grunt-cli'] ]
}
