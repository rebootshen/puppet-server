node base {
	include test
	include httpd
}

node default {
  notify { "== No node name found  ! use default !": }
  file {
    "/tmp/hello.txt": content => "hello world";
  }
}

node 'node1','node2' inherits base {

	file
	{ 
	"/opt/redisdir":    
	source => "puppet://puppet/files/redisdir",
	recurse=>true,    
	ensure=>directory, 
	force=>true 
	}
}
