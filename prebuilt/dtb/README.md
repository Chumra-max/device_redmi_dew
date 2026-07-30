Drop your extracted stock DTB here, named `*.dtb` (any name ending .dtb works,
BOARD_PREBUILT_DTBIMAGE_DIR concatenates every *.dtb file in this folder).

You almost certainly already have it — when you ran `magiskboot unpack boot.img`
to get the kernel, check that same output directory for a file called `dtb`.

    mv dtb device_tree.dtb
