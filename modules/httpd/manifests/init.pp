class httpd {
	yumrepo { 
		"repo163":
		descr => "163 repo",
		baseurl => "http://tel.mirrors.163.com/centos/7/os/x86_64/",
		gpgcheck => "0",
		enabled => "1";
	}
	
	package {
		"httpd":
		ensure => installed,
		require => yumrepo["repo163"];
	}
}


