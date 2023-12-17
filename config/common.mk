# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= LineVallOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# Permissions for lineage sdk services
PRODUCT_COPY_FILES += \
    vendor/linevall/config/permissions/org.lineageos.health.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.health.xml \
    vendor/linevall/config/permissions/org.lineageos.livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.livedisplay.xml \
    vendor/linevall/prebuilt/common/etc/permissions/privapp-permissions-livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-livedisplay.xml

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Include Google sysconfigs
PRODUCT_COPY_FILES += \
    vendor/linevall/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/dialer_experience.xml \
    vendor/linevall/prebuilt/common/etc/sysconfig/google.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google.xml \
    vendor/linevall/prebuilt/common/etc/sysconfig/google_build.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google_build.xml \
    vendor/linevall/prebuilt/common/etc/sysconfig/google_exclusives_enable.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google_exclusives_enable.xml \
    vendor/linevall/prebuilt/common/etc/sysconfig/google-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google-hiddenapi-package-whitelist.xml \
    vendor/linevall/prebuilt/common/etc/sysconfig/nexus.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/nexus.xml \
    vendor/linevall/prebuilt/common/etc/sysconfig/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_2016_exclusive.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= $(TARGET_SUPPORTS_64_BIT_APPS)

ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    ParanoidSense

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Skip boot JAR checks.
SKIP_BOOT_JARS_CHECK := true

# TextClassifier
PRODUCT_PACKAGES += \
    libtextclassifier_annotator_en_model \
    libtextclassifier_annotator_universal_model \
    libtextclassifier_actions_suggestions_universal_model \
    libtextclassifier_lang_id_model

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Gapps
ifeq ($(BUILD_WITH_GAPPS),true)
$(call inherit-product-if-exists, vendor/gms/products/gms.mk)
endif

# Include AOSP audio files
include vendor/linevall/config/aosp_audio.mk

# Incude LineVall Branding
include vendor/linevall/config/version.mk

# Inherit SystemUI Clocks if they exist
$(call inherit-product-if-exists, vendor/SystemUIClocks/product.mk)

# Include Linevall Packages
include vendor/linevall/config/packages.mk
include vendor/prebuilts/prebuilts.mk

# Include LineVall_props
$(call inherit-product, vendor/linevall/config/linevall_props.mk)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
