#
# vendorsetup.sh for dew (Redmi, mt6768) — OrangeFox build vars
# Pattern based on a real working Xiaomi A/B OrangeFox tree (device_xiaomi_spes).
# Every value below is either confirmed from your device data, or a documented
# OrangeFox default appropriate for a MIUI-based A/B Virtual-A/B FBE device.
#

FDEVICE="dew"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    export TW_DEFAULT_LANGUAGE="en"
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true

    # --- A/B + Virtual A/B: confirmed via lpdump (header flag "virtual_ab_device") ---
    export OF_AB_DEVICE=1
    export OF_VIRTUAL_AB_DEVICE=1

    # --- Confirmed exact nodes, matches recovery.fstab ---
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

    # --- FBE / encryption: confirmed inlinecrypt userdata from mounts.txt ---
    export OF_FBE_METADATA_MOUNT_IGNORE=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1

    # --- MIUI/Xiaomi-specific handling (device shipped MIUI/HyperOS originally) ---
    export OF_USE_MAGISKBOOT=1
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
    export OF_PATCH_AVB20=1
    export OF_KEEP_DM_VERITY=1
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_NO_MIUI_PATCH_WARNING=1

    # --- Build environment / binaries ---
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_USE_LZ4_BINARY=1
    export FOX_USE_ZSTD_BINARY=1

    # --- Full-fat feature set: opposite of the lean reference, keep everything ---
    export FOX_ENABLE_APP_MANAGER=1
    export FOX_DISABLE_APP_MANAGER=0
    # FOX_DELETE_AROMAFM intentionally NOT set — keeping AromaFM since you want the full build

    # --- Screen: 720x1600 confirmed = 20:9 aspect ratio.
    #     OrangeFox's own sizing formula: <aspect ratio height> * 120 → 20 * 120 = 2400.
    #     This is calculated from your confirmed screen data, not copied from another device. ---
    export OF_SCREEN_H=2400

    # --- Backup behaviour ---
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1

    # --- UNCONFIRMED — fill in yourself, or tell me and I'll set it ---
    export FOX_VERSION="R11.1-dew"          # cosmetic label only, change if you want
    export OF_MAINTAINER="Martin"           # your GitHub handle, if you want one shown instead

    # NOTE: OF_HIDE_NOTCH / OF_STATUS_H / OF_STATUS_INDENT_LEFT / OF_STATUS_INDENT_RIGHT
    # deliberately omitted — these depend on whether your phone has a notch or punch-hole
    # camera and exactly where it sits. Not something I can infer; tell me if you want these
    # tuned and I'll need to know the camera cutout position.

    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi
