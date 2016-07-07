class test {
	file { "/tmp/$hostname.txt": 
		content => "Hello World from Sam !"
	}

	file { "/opt/create-dir.sh":
        source => "puppet:///modules/test/create-dir.sh",
	ensure => 'present',
	mode => '0755',
	owner => 'puppet',
	group => 'puppet'
        }

        exec { "exec-mkdir":
        cwd => "/opt",
	timeout => 7200,
        logoutput => on_failure,
        user => "root",
        path => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin",
	require => File["/opt/create-dir.sh"],
        command => "sh /opt/create-dir.sh",
	creates => '/opt/shelldir'
        }

	exec { 'create_needed_dir':
	  command => '/bin/mkdir -p /tmp/needed',
	  creates => '/tmp/needed'
	}


        package {
                "cronie":
                ensure => installed
	}

	exec { 'start_crond':
	  command => '/usr/sbin/crond -n&',
	  path   => '/usr/bin:/usr/sbin:/bin',
	  onlyif => 'test -f /opt/create-dir.sh' 
	}

	cron { "cron-shell": 
	command => "sh /opt/create-dir.sh",
	user => "root",  
	minute => "42", 
	hour => "08" 
	}
}
