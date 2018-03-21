# Creating persistence #

What is persistence?

Since your live system is read only nothing gets stored between reboots. Persistence is a way to keep certain files once the system is powered off.

But hang on mate, why do I need to keep certain files persistent in a read only system? Doesn't that defeat the purpose?

Yes and no. Sure when you keep something it already means that it is not 100% read only. On the other hand, there are certain conveniences that are lost when you have 100% read only system. For example say you wanted to save the hotel's wifi password. Or say you create a document, and you don't want it to be lost. For those reasons we create persistence. Naturally we encrypt anything we store.

By default we encrypt our persistence volume and persist the following configuration files


    ./wicd/wireless-settings.conf
    ./wicd/manager-settings.conf
    ./romix/romix.conf
    ./modprobe.d/alsa-base.conf
    AND any changes to /home

To create persistence you need to create a separate partition, encrypt it, create a file system on it, and tell our live system to find it, ask for password, and properly mount it.

Create a partition sudo fdisk <USB Device, ex /dev/sdc> Follow propts to create a new partition. Note the new partition number.
Encrypt the partition cryptsetup luksFormat <USB device+partition> ex. /dev/sdc3
Mount the partition and create a file system

    cryptsetup luksOpen <USB device+partition number>
    ex. /dev/sdc3
    
    mkfs.ext4 -L urulu /dev/mapper/live

Note: It is important to lable the file system “urulu” as specified above. Why? Cause Urulu is the greatest rock! And that is how the system will know to attempt to mount it.

Mount the ifle sytem and copy some stuff

    mount /dev/mapper/live /mnt
    tar xvf persistence.tar -C /mnt
    Unmount and close. We are ready to go
    umount /mnt
    cryptsetup luksClose live


## Multiple Persistence Files ##


http://manpages.ubuntu.com/manpages/trusty/man5/persistence.conf.5.html



    dd if=/dev/null of=persistence bs=1 count=0 seek=1G # for a 1GB sized image file
    $ /sbin/mkfs.ext4 -F persistence


Once the image file is created, If the image file is located in your home directory, copy it to the root of your hard drive's filesystem 