##Phylosophy
We believe that it is important to have a system  that is both secure and is easy to use. We imagined a system that is protected from malware, randsomware, behavior tracking, and hacking. A system that does its best to let you consume and create data and protect it, protect you, and itself at the same time. 

The challenge is that with all the components that make up a consumer computing environment today, it is impossible to fully secure it. Therefore we decided to build on the idea of resilience - even if a single or multiple components get compromised, they would be automatically restored to pristine state without affecting any data. Hence, the idea of a read only system was born. 

We also were tired of all the bloatware and completely unnecessary components. These are both hard to secure since they have a bigger attack surface and  they consume too much unnecessary resources. Hence, an idea to have a minimalist read only system was born.


_Why create romix when there are plenty of other live distros?_
We wanted minimalist yet usable read only distro that is also laptop friendly. We couldn't find one we liked, so we build one

_What is this romix thing?_
Romix is a minimalist live system that consists of a simple openbox environment that has all the basic functionality you'd expect on a laptop, such as brightness control, suspend on lid and other things we normally take for granted.

It is fully customizable – you get the basic environment. Add any package you need, build it, burn it, use it.

It is based on debian live Thanks to the guys and gals at https://www.debian.org/devel/debian-live/ that have such a awesome framework for live systems. 

_Is it only usable as a live system?_
Not at all. In fact, it is not always practical to run your laptop off a USB key all the time. You can install romix as a regular linux system and it will create a usable minimalist debian environment for you. 

##Installing
At the moment you have to build one yourself. Don't worry it is easy:

You need a working debian distribution. And live-build

```sudo apt-get install live-build```

Clone this repo, and run lb-confg and lb-build. At the moment you need to be root when you do this.

```sudo /bin/bash```
```lb config```
```lb build```

let it run and at the end you'll have an ISO image that you need to copy to your USB key. 

*Note that this will completley wipe all the information on the destination drive*

```sudo dd if=./<iso image> of=/dev/sd?```
where “?” is the name of your USB key. For exmaple 
```sudo dd if=./live of=/dev/sdc


##Customizing & Configuring
There is a configuration file that you can edit ether prior to building the ISO image  _config/includes.chroot/etc/romix/romix.conf_ it is pretty much self-explanatory. 

###Adding packages
By default romix gives you a working system with very little tools and utilities. If you want to add another package, edit the following file _/config/package-lists/custom.list.chroot_ 

Note that there are multiple other ways to add packages. This is just the simpler one. 

*Importaint* if you are running on a Lenovo X1 Carbon uncomment the following line in the _config/includes.chroot/etc/modprobe.d/alsa-base.conf_

```
#options snd_hda_intel index=1
```
Otherwise the sound will not work.


##Creating persistence

_What is persistence?_
Since your live system is read only nothing gets stored between reboots. Persistence is a way to keep certain files once the system is powered off.

_But hang on mate, why do I need t keep certain files in a read only system? Doesn't that defeat the purpose?_
Yes and no. Sure when you keep something it already means that it is not 100% read only. On the other hand, there are certain conveniences that are lost when you have 100% read only system. For example say you wanted to save the hotel's wifi password. Or say you create a document, and you don't want it to be lost. For those reasons we create persistence. Naturally we encrypt anything we store.

  
By default we encrypt our persistence volume and persist the following configuration files

./wicd/wireless-settings.conf
./wicd/manager-settings.conf
./romix/romix.conf
./modprobe.d/alsa-base.conf

*AND* any changes to /home


To create persistence you need to create a separate partition, encrypt it, create a file system on it, and tell our live system to find it, ask for password, and properly mount it.

1. Create a partition
```sudo fdisk <USB Device, ex /dev/sdc>```
Follow propts to create a new partition. Note the new partition number.
2. Encrypt the partition 

```cryptsetup luksFormat <USB device+partition ex. /dev/sdc3>```

3. Mount the partition and create a file system

```
cryptsetup luksOpen <USB device+partition number ex. /dev/sdc3> live
mkfs.ext4 -L urulu /dev/mapper/live
```
Note: It is important to lable the file system “urulu” as specified above. Why? Cause Urulu is the greatest rock! And that is how the system will know to attempt to mount it.

4. Mount the ifle sytem and copy some stuff
```
mount /dev/mapper/live /mnt
tar xvf persistence.tar -C /mnt
```
5. Unmount and close. We are ready to go
```
umount /mnt
cryptsetup luksClose live
```

####Using a caching proxy
If you plan on making multiple builds it is better to install and use a caching proxy. Live-build downloads all the packages it needs from a debian mirror, having a local cache copy saves you time and bandwidth.

Squid works fine. Install squid

```sudo apt-get install squid```

And use this for the config file. 

```
acl CONNECT method CONNECT
acl SSL_ports port 443
cache_dir ufs /media/romix/package_cache 4000 16 256
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
```

Uncomment the following line in ./auto/config

```
#	--apt-http-proxy http://localhost:3128/ \
```

and also set your environment variable so that lb build knows to use the proxy
```export http_proxy=http://localhost:3128/```

