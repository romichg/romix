# Installing Romix #

## From Debian ##

WARNING: The following instructions will completley wipe all the information on the destination drive.

Use the following command to copy the Romix ISO image to the bootable media of your choice.

    sudo dd if=./<name iso image> of=<device of your USB key>

For example:

    sudo dd if=./live-image-amd64.hybrid.iso of=/dev/sdc


## Default Credentials ##

    Username: romix
    Password: live


## Notes ##

    unetbootin
    initrd fix
    syslinux


### Installed Apps ###

    nautilus
    xfreerdp
