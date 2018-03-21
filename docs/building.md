# Building Romix #

It is easy to build Romix yourself. You need a working Debian distribution to perform the following:

1. **Install the ``live-build`` package.** Use the following command to install the ``live-build`` package:

        sudo apt-get install live-build

2. **Clone the Romix GitHub repository.** Place the files in the repository somewhere within your Debian system.

3. **Run ``live-build`` inside the local repository files.** You need to be root and run the following commands:

        sudo /bin/bash
        lb config
        lb build

4. **Copy the produced ISO image.** Let ``live-build`` run and at the end you'll have an ISO image that you need to copy to your USB key or another bootable storage media.


## Using a Caching Proxy to Reduce Network Usage ##

If you plan on making multiple builds, it is recommended to install and use a caching proxy. Live-build downloads all the packages it needs from a debian mirror, having a local cache copy saves you time and bandwidth.

Squid works fine. Install squid

    sudo apt-get install squid

Use the following settings for the config file.

Before you use the file make sure that `` cache_dir `` exists and is owned by "proxy" user. You can change the `` cache_dir `` to whatever works on your system

    acl Safe_ports port 80		# http
    acl Safe_ports port 21		# ftp
    acl Safe_ports port 443		# https
    acl Safe_ports port 70		# gopher
    acl Safe_ports port 210		# wais
    acl Safe_ports port 1025-65535	# unregistered ports
    acl Safe_ports port 280		# http-mgmt
    acl Safe_ports port 488		# gss-http
    acl Safe_ports port 591		# filemaker
    acl Safe_ports port 777		# multiling http
    acl CONNECT method CONNECT
    acl SSL_ports port 443
    cache_dir ufs /media/romix/http_cache/ 4000 16 256
    cache_mem 8 MB
    coredump_dir /var/spool/squid3
    http_access allow localhost
    http_access allow localhost manager
    http_access deny all
    http_access deny CONNECT !SSL_ports
    http_access deny manager
    http_access deny !Safe_ports
    http_port 3128
    maximum_object_size 200 MB
    maximum_object_size_in_memory 512 KB
    minimum_object_size 0 bytes
    refresh_pattern .		0	20%	4320
    refresh_pattern ^ftp:		1440	20%	10080
    refresh_pattern ^gopher:	1440	0%	1440
    refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
    
Uncomment the following line in ./auto/config
    
    #	--apt-http-proxy http://localhost:3128/ \
    
and also set your environment variable so that lb build knows to use the proxy:

    export http_proxy=http://localhost:3128/

### Notes: ###

Does ``lb clean`` clean up the build directory well?