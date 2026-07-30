Drop your extracted stock kernel binary here, named `Image`.

    SLOT=$(getprop ro.boot.slot_suffix)
    su -c "dd if=/dev/block/by-name/boot$SLOT of=/sdcard/boot.img"
    adb pull /sdcard/boot.img
    magiskboot unpack boot.img
    mv kernel Image
