exec { 'update_apt':
  command => 'apt-get update',
  path => '/usr/bin'
}

class { 'git': }

class { 'nodejs':
  version => 'v0.8.25',
}

package { 'grunt-cli':
  ensure => 'present',
  provider => 'npm'
}

vcsrepo { "/srv/habit-rpg":
  ensure => latest,
  provider => git,
  source => 'https://github.com/lefnire/habitrpg.git',
  revision => 'develop',
  user => 'vagrant'
}

file { "/srv/habit-rpg/config.json":
  owner => vagrant,
  group => vagrant,
  mode => 550,
  source => "/srv/habit-rpg/config.json.example"
}
