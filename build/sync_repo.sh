#!/bin/bash

# Sync VM --> repo
# (wipe src/, copy VM to src/. To copy over src/ in-place, comment out the `rm -rf ../src/*` line.)

sudo modprobe nbd

echo "Edit this script first to pick your VM path & file!"
exit # Comment this line out

# Uncomment ONE of the next lines and edit it to point to your VM HDD
# sudo qemu-nbd -c dev/nbd0 ~/VirtualBox\ VMs/ZealOS/ZealOS.vdi
# sudo qemu-nbd -c dev/nbd0 ~/vmware/ZealOS/ZealOS.vmdk
# sudo qemu-nbd -c dev/nbd0 ZealOS.qcow2

sudo partprobe /dev/nbd0
sudo mount /dev/nbd0p1 /mnt
echo "removing src/ files"
rm -rf ../src/*
echo "copying src/ files from root of mounted hdd"
sudo cp -r /mnt/* ../src/
sudo rm ../src/Boot/BootMHD2.BIN.C
echo "src/ files copied"
echo "unmounting..."
sudo umount /mnt
sudo qemu-nbd -d /dev/nbd0
echo "unmounted hdd"
echo "set perms"
sudo chown -R $USER:$USER ../src/*
mv ../src/Tmp/AUTO.ISO.C ./AUTO.ISO
echo "finished."
git status