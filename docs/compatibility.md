# Compatibility #

## Lenovo X1 ##

If you are running on a Lenovo X1 Carbon uncomment the following line in ``config/includes.chroot/etc/modprobe.d/alsa-base.conf``

    #options snd_hda_intel index=1

Otherwise sound will not work.