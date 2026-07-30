LOCAL_PATH := device/redmi/dew

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/etc/recovery.fstab

# NOTE: device actually shipped on API 35 (HyperOS/Android 15), but this must
# match the fox_14.1 (Android 14) source tree's BOARD_SYSTEMSDK_VERSIONS ceiling,
# not the stock ROM version — see build/make/core/config.mk:865
PRODUCT_SHIPPING_API_LEVEL := 34

# Confirmed: eMMC storage, Virtual A/B, EROFS system-tier partitions, f2fs data/metadata
PRODUCT_PACKAGES += \
    fastbootd
