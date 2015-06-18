class stevesecondsight_apache (
 $vhost,
 $docroot,
 $source_repo,
){
# this install apache for you ! nice init
class {'apache':}

# define some shit 
apache::vhost { $vhost:
 port        => '80',
 docroot => $docroot,
 }

# install the git pacakage 
package{'git':
 ensure => present,
 }
 # clone the site content into place 
 vcsrepo { $docroot:
 owner     => 'apache',
 group      => 'apache',
 provider => git,
 source    => $source_repo,
 }

 # ensure things work 
 Class['apache'] -> Apache::Vhost[$vhost] -> Vcsrepo[$docroot]
 Package['git'] -> Vscrepo[$docroot]
}