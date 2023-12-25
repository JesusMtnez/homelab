---
title: Local environemnt
---

Bootin DietPi ARMv8 image using QEMU/KVM as in a Raspberry Pi 3B.

1. Download [latest DietPi][dietpi-download] image for Raspberry Pi:

2. Extract _dtb_ and _kernel_:

```bash
sudo losetup --show -fP DietPi_RPi-ARMv8-Bookworm.img # i.e. /dev/loop0

mkdir boot
sudo mount /dev/loop0p1 boot

cp boot/kernel8.img boot/bcm2710-rpi-3-b.dtb .

sudo umount boot
sudo losetup -d /dev/loop0
```

3. Resize image

```sh
qemu-image resize -f raw DietPi_RPi-ARMv8-Bookworm.img 32GB
```

4. Run using `qemu-system-aarch64`

```sh
qemu-system-aarch64 \
  -M raspi3b \
  -m 1G -smp 4 \
  -kernel kernel8.img \
  -dtb bcm2710-rpi-3-b.dtb \
  -drive file=DietPi_RPi-ARMv8-Bookworm.img,format=raw \
  -append "console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4" \
  -device usb-net,netdev=net0 \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device usb-mouse \
  -device usb-kbd \
  -serial stdio
```

!!! tip
    Use `-nographic` instead of `-serial stdio` to disable monitor.

!!! info
    `hostfwd=tcp::2222-:22` will forward port 22 to port 2222 in host machine.

  [dietpi-download]: https://dietpi.com/#download
