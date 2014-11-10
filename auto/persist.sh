fdisk $1
cryptsetup --verify-passphrase luksFormat $12
cryptsetup luksOpen $12 live
mkfs.ext4 -L urulu /dev/mapper/live
mount /dev/mapper/live /mnt
echo "/ union" > /mnt/persistence.conf
#echo "/home union" > /mnt/persistence.conf
umount /mnt
cryptsetup luksClose live
