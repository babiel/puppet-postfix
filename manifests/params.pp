# @!visibility private
class postfix::params {

  $conf_dir     = '/etc/postfix'
  $package_name = 'postfix'
  $service_name = 'postfix'

  case $::osfamily {
    'RedHat': {
      $lookup_packages                     = {}
      $_services                           = {
        'anvil/unix'      => {
          'chroot'  => 'n',
          'command' => 'anvil',
          'limit'   => '1',
        },
        'bounce/unix'     => {
          'chroot'  => 'n',
          'command' => 'bounce',
          'limit'   => '0',
        },
        'cleanup/unix'    => {
          'chroot'  => 'n',
          'command' => 'cleanup',
          'limit'   => '0',
          'private' => 'n',
        },
        'defer/unix'      => {
          'chroot'  => 'n',
          'command' => 'bounce',
          'limit'   => '0',
        },
        'discard/unix'    => {
          'chroot'  => 'n',
          'command' => 'discard',
        },
        'error/unix'      => {
          'chroot'  => 'n',
          'command' => 'error',
        },
        'flush/unix'      => {
          'chroot'  => 'n',
          'command' => 'flush',
          'limit'   => '0',
          'private' => 'n',
          'wakeup'  => '1000?',
        },
        'lmtp/unix'       => {
          'chroot'  => 'n',
          'command' => 'lmtp',
        },
        'local/unix'      => {
          'chroot'       => 'n',
          'command'      => 'local',
          'unprivileged' => 'n',
        },
        'proxymap/unix'   => {
          'chroot'  => 'n',
          'command' => 'proxymap',
        },
        'proxywrite/unix' => {
          'chroot'  => 'n',
          'command' => 'proxymap',
          'limit'   => '1',
        },
        'relay/unix'      => {
          'chroot'  => 'n',
          'command' => 'smtp',
        },
        'retry/unix'      => {
          'chroot'  => 'n',
          'command' => 'error',
        },
        'rewrite/unix'    => {
          'chroot'  => 'n',
          'command' => 'trivial-rewrite',
        },
        'scache/unix'     => {
          'chroot'  => 'n',
          'command' => 'scache',
          'limit'   => '1',
        },
        'showq/unix'      => {
          'chroot'  => 'n',
          'command' => 'showq',
          'private' => 'n',
        },
        'smtp/inet'       => {
          'chroot'  => 'n',
          'command' => 'smtpd',
          'private' => 'n',
        },
        'smtp/unix'       => {
          'chroot'  => 'n',
          'command' => 'smtp',
        },
        'tlsmgr/unix'     => {
          'chroot'  => 'n',
          'command' => 'tlsmgr',
          'limit'   => '1',
          'wakeup'  => '1000?',
        },
        'trace/unix'      => {
          'chroot'  => 'n',
          'command' => 'bounce',
          'limit'   => '0',
        },
        'verify/unix'     => {
          'chroot'  => 'n',
          'command' => 'verify',
          'limit'   => '1',
        },
        'virtual/unix'    => {
          'chroot'       => 'n',
          'command'      => 'virtual',
          'unprivileged' => 'n',
        },
      }
      $alias_database                      = ['hash:/etc/aliases']
      $alias_maps                          = ['hash:/etc/aliases']
      $command_directory                   = '/usr/sbin'
      $daemon_directory                    = '/usr/libexec/postfix'
      $data_directory                      = '/var/lib/postfix'
      $debug_peer_level                    = '2'
      $debugger_command                    = 'PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin ddd $daemon_directory/$process_name $process_id & sleep 5'
      $default_database_type               = 'hash'
      $html_directory                      = false
      $inet_interfaces                     = ['localhost']
      $inet_protocols                      = ['all']
      $mail_owner                          = 'postfix'
      $mailq_path                          = '/usr/bin/mailq.postfix'
      $manpage_directory                   = '/usr/share/man'
      $mydestination                       = ['$myhostname', 'localhost.$mydomain', 'localhost']
      $newaliases_path                     = '/usr/bin/newaliases.postfix'
      $queue_directory                     = '/var/spool/postfix'
      $sendmail_path                       = '/usr/sbin/sendmail.postfix'
      $setgid_group                        = 'postdrop'
      $unknown_local_recipient_reject_code = '550'

      case $::operatingsystemmajrelease {
        '6': {
          $services         = merge($_services, {
            'pickup/fifo' => {
              'chroot'  => 'n',
              'command' => 'pickup',
              'limit'   => '1',
              'private' => 'n',
              'wakeup'  => '60',
            },
            'qmgr/fifo'   => {
              'chroot'  => 'n',
              'command' => 'qmgr',
              'limit'   => '1',
              'private' => 'n',
              'wakeup'  => '300',
            },
            'relay/unix'  => {
              'chroot'  => 'n',
              'command' => 'smtp -o smtp_fallback_relay=',
            },
          })
          $readme_directory = '/usr/share/doc/postfix-2.6.6/README_FILES'
          $sample_directory = '/usr/share/doc/postfix-2.6.6/samples'
        }
        default: {
          $services         = merge($_services, {
            'pickup/unix' => {
              'chroot'  => 'n',
              'command' => 'pickup',
              'limit'   => '1',
              'private' => 'n',
              'wakeup'  => '60',
            },
            'qmgr/unix'   => {
              'chroot'  => 'n',
              'command' => 'qmgr',
              'limit'   => '1',
              'private' => 'n',
              'wakeup'  => '300',
            },
          })
          $readme_directory = '/usr/share/doc/postfix-2.10.1/README_FILES'
          $sample_directory = '/usr/share/doc/postfix-2.10.1/samples'
        }
      }
    }
    'Debian': {
      $lookup_packages                     = {
        'cdb'   => 'postfix-cdb',
        'ldap'  => 'postfix-ldap',
        'mysql' => 'postfix-mysql',
        'pcre'  => 'postfix-pcre',
        'pgsql' => 'postfix-pgsql',
      }
      $services                            = {
        'smtp/inet'          => {
          'private' => 'n',
          'chroot'  => 'y',
          'command' => 'smtpd',
        },
        'pickup/unix'        => {
          'private' => 'n',
          'chroot'  => 'y',
          'wakeup'  => '60',
          'limit'   => '1',
          'command' => 'pickup',
        },
        'cleanup/unix'       => {
          'private' => 'n',
          'chroot'  => 'y',
          'limit'   => '0',
          'command' => 'cleanup',
        },
        'qmgr/unix'          => {
          'private' => 'n',
          'chroot'  => 'n',
          'wakeup'  => '300',
          'limit'   => '1',
          'command' => 'qmgr',
        },
        'tlsmgr/unix'        => {
          'chroot'  => 'y',
          'wakeup'  => '1000?',
          'limit'   => '1',
          'command' => 'tlsmgr',
        },
        'rewrite/unix'       => {
          'chroot'  => 'y',
          'command' => 'trivial-rewrite',
        },
        'bounce/unix'        => {
          'chroot'  => 'y',
          'limit'   => '0',
          'command' => 'bounce',
        },
        'defer/unix'         => {
          'chroot'  => 'y',
          'limit'   => '0',
          'command' => 'bounce',
        },
        'trace/unix'         => {
          'chroot'  => 'y',
          'limit'   => '0',
          'command' => 'bounce',
        },
        'verify/unix'        => {
          'chroot'  => 'y',
          'limit'   => '1',
          'command' => 'verify',
        },
        'flush/unix'         => {
          'private' => 'n',
          'chroot'  => 'y',
          'wakeup'  => '1000?',
          'limit'   => '0',
          'command' => 'flush',
        },
        'proxymap/unix'      => {
          'chroot'  => 'n',
          'command' => 'proxymap',
        },
        'proxywrite/unix'    => {
          'chroot'  => 'n',
          'limit'   => '1',
          'command' => 'proxymap',
        },
        'smtp/unix'          => {
          'chroot'  => 'y',
          'command' => 'smtp',
        },
        'relay/unix'         => {
          'chroot'  => 'y',
          'command' => 'smtp -o syslog_name=postfix/$service_name',
        },
        'showq/unix'         => {
          'private' => 'n',
          'chroot'  => 'y',
          'command' => 'showq',
        },
        'error/unix'         => {
          'chroot'  => 'y',
          'command' => 'error',
        },
        'retry/unix'         => {
          'chroot'  => 'y',
          'command' => 'error',
        },
        'discard/unix'       => {
          'chroot'  => 'y',
          'command' => 'discard',
        },
        'local/unix'         => {
          'unprivileged'  => 'n',
          'chroot'        => 'n',
          'command'       => 'local',
        },
        'virtual/unix'       => {
          'unprivileged'  => 'n',
          'chroot'        => 'n',
          'command'       => 'virtual',
        },
        'lmtp/unix'          => {
          'chroot'  => 'y',
          'command' => 'lmtp',
        },
        'anvil/unix'         => {
          'chroot'  => 'y',
          'limit'   => '1',
          'command' => 'anvil',
        },
        'scache/unix'        => {
          'chroot'  => 'y',
          'limit'   => '1',
          'command' => 'scache',
        },
        'postlog/unix-dgram' => {
          'private' => 'n',
          'chroot'  => 'n',
          'limit'   => '1',
          'command' => 'postlogd',
        },
      }
      $alias_database                      = undef
      $alias_maps                          = undef
      $command_directory                   = undef
      $daemon_directory                    = undef
      $data_directory                      = undef
      $debug_peer_level                    = undef
      $debugger_command                    = undef
      $default_database_type               = 'hash'
      $html_directory                      = undef
      $inet_interfaces                     = undef
      $inet_protocols                      = undef
      $mail_owner                          = undef
      $mailq_path                          = undef
      $manpage_directory                   = undef
      $mydestination                       = undef
      $newaliases_path                     = undef
      $queue_directory                     = undef
      $readme_directory                    = undef
      $sample_directory                    = undef
      $sendmail_path                       = undef
      $setgid_group                        = undef
      $unknown_local_recipient_reject_code = undef
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
