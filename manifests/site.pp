node default
{
        file { 
		"/tmp/puppettest1.txt": content => "Hello,First Puppet test"; 
		} 
}