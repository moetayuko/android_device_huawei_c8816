$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/huawei/c8816/c8816-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/huawei/c8816/overlay

LOCAL_PATH := device/huawei/c8816
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Files
PRODUCT_COPY_FILES += \
    device/huawei/c8816/ramdisk/fstab.qcom:root/fstab.qcom \
    device/huawei/c8816/ramdisk/tp/1191601.img:root/tp/1191601.img

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_c8816
PRODUCT_DEVICE := c8816
