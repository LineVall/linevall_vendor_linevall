LOCAL_PATH := $(call my-dir)

include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := SettingsIntelligenceGoogle
LOCAL_OVERRIDES_PACKAGES := SettingsIntelligence
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := priv-app/$(LOCAL_MODULE).apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_CLASS := APPS
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_DEX_PREOPT := false
LOCAL_PRODUCT_MODULE := true
include $(BUILD_PREBUILT)
