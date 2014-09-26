#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# ramdisk
PRODUCT_COPY_FILES += \
    device/huawei/c8816/ramdisk/fstab.qcom:root/fstab.qcom \
    device/huawei/c8816/ramdisk/tp/1191601.img:root/tp/1191601.img \
    device/huawei/c8816/ramdisk/init.qcom.class_core.sh:root/init.qcom.class_core.sh \
    device/huawei/c8816/ramdisk/init.qcom.class_main.sh:root/init.qcom.class_main.sh \
    device/huawei/c8816/ramdisk/init.qcom.early_boot.sh:root/init.qcom.early_boot.sh \
    device/huawei/c8816/ramdisk/init.qcom.factory.sh:root/init.qcom.factory.sh \
    device/huawei/c8816/ramdisk/init.qcom.ril.sh:root/init.qcom.ril.sh \
    device/huawei/c8816/ramdisk/init.qcom.sh:root/init.qcom.sh \
    device/huawei/c8816/ramdisk/init.qcom.ssr.sh:root/init.qcom.ssr.sh \
    device/huawei/c8816/ramdisk/init.qcom.syspart_fixup.sh:root/init.qcom.syspart_fixup.sh \
    device/huawei/c8816/ramdisk/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/huawei/c8816/ramdisk/ueventd.qcom.rc:root/ueventd.qcom.rc

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_c8816
PRODUCT_DEVICE := c8816
