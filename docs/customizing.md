# Customizing Romix #

There is a configuration file that you can edit prior to building the ISO image:

    config/includes.chroot/etc/romix/romix.conf


## Adding packages ##

By default Romix gives you a working system with very little tools and utilities. If you want to add another package, edit the following file:

    /config/package-lists/custom.list.chroot

Note that there are multiple other ways to add packages. This is just one of the simplest.


## Examples ##

Disable fehbg script in ~/.config/openbox/autostart to disable wallpaper.

Change fonts in ~/.config/openbox/rc.xml


## Links ##

* [Package Lists](https://github.com/roman87/romix/tree/master/config/package-lists)
* [includes.chroot](https://github.com/roman87/romix/tree/master/config/includes.chroot)
* [hooks](https://github.com/roman87/romix/tree/master/config/hooks)
* [isolinux](https://github.com/roman87/romix/tree/master/config/bootloaders/isolinux)
* [OpenBox autostart](https://github.com/roman87/romix/blob/master/config/includes.chroot/etc/skel/.config/openbox/autostart)
* [Debian Live Documentation](https://debian-live.alioth.debian.org/live-manual/stable/manual/html/live-manual.en.html)