LOCAL_PATH := device/redmi/dew

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/etc/recovery.fstab

# Confirmed via ro.vendor.build.version.sdk / ro.product.first_api_level
PRODUCT_SHIPPING_API_LEVEL := 35

# Confirmed: eMMC storage, Virtual A/B, EROFS system-tier partitions, f2fs data/metadata
PRODUCT_PACKAGES += \
    fastbootd
