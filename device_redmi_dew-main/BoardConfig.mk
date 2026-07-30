# BoardConfig.mk for dew (Redmi, MediaTek mt6768)
# Values sourced from: mkbootimg_args.json, /dev/block/by-name, blockdev --getsize64

TARGET_BOARD_PLATFORM := mt6768
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# --- Kernel / boot image (confirmed from mkbootimg_args.json) ---
BOARD_BOOT_HEADER_VERSION := 4
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x4bc80000
BOARD_RAMDISK_OFFSET := 0x47c80000
BOARD_DTB_OFFSET := 0x4bc80000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
# Required unconditionally by vendor/twrp/build/tasks/kernel.mk regardless of
# BUILD_TARGET (boot/recovery/vendorboot) — it's parsed on every build.
TARGET_PREBUILT_KERNEL := device/redmi/dew/prebuilt/kernel/Image

# --- A/B + Dynamic Partitions (confirmed from by-name + /proc/mounts dm- entries) ---
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += boot vendor_boot dtbo vbmeta vbmeta_system vbmeta_vendor super
BOARD_USES_METADATA_PARTITION := true
BOARD_SUPER_PARTITION_SIZE := 9663676416
# Confirmed via lpdump: header flag virtual_ab_device, group base name "main",
# slots main_a/main_b auto-suffixed. No standalone "odm" — Xiaomi merges it,
# but there IS a Xiaomi-specific "mi_ext" logical partition (mounts at /mnt/vendor/mi_ext).
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 9653190656
BOARD_MAIN_PARTITION_LIST := system vendor product system_ext vendor_dlkm odm_dlkm system_dlkm mi_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm

# --- Filesystem (confirmed from /proc/mounts — system-tier partitions are EROFS, not ext4) ---
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EROFS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
# Confirmed via magic-byte check (dd/xxd superblock read) — both erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_HAS_NO_REAL_SDCARD := true

# --- Recovery ---
# CORRECTED: recovery lives in vendor_boot on this device (confirmed by flashing
# behaviour with other recoveries), NOT merged into boot. AOSP requires
# BOARD_USES_RECOVERY_AS_BOOT to be left empty for this layout — do not set it.
# BOARD_USES_RECOVERY_AS_BOOT :=
TARGET_RECOVERY_FSTAB := device/redmi/dew/recovery.fstab
TW_INCLUDE_LOGICAL := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE := true
TW_INCLUDE_FBE_METADATA := true
# userdata uses inlinecrypt (confirmed in /proc/mounts) — needed for decrypt in recovery
TW_USE_TOOLBOX := true
TW_EXCLUDE_APEX := true
TW_NO_HAPTICS := true
BOARD_HAS_MTK_HARDWARE := true

# --- OrangeFox (OFRP) specific settings ---
# A/B device – required to replace obsolete OF_AB_DEVICE
FOX_AB_DEVICE := 1
# Virtual A/B (dynamic partitions) – your device uses it (from lpdump flag)
FOX_VIRTUAL_AB_DEVICE := 1
# VANILLA build – disable block-OTA compatibility (avoids GApps requirement)
OF_SUPPORT_ALL_BLOCK_OTA_UPDATES := false

# --- Display (confirmed: 720x1600, density 320/override 311 — standard portrait phone) ---
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 162

TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_DOWNLOAD_MODE := true

# Fix 32-bit apps on 64-bit device build error
TARGET_SUPPORTS_64_BIT_APPS := false
