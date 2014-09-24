## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := c8816

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/huawei/c8816/device_c8816.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := c8816
PRODUCT_NAME := cm_c8816
PRODUCT_BRAND := Huawei
PRODUCT_MODEL := HUAWEI C8816
PRODUCT_MANUFACTURER := HUAWEI
