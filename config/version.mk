# Copyright (C) 2018-23 The LineageOS Project
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

#LineVall OS Versioning :
LINEVALL_MOD_VERSION = Fourteen-Alpha

ifndef LINEVALL_BUILD_TYPE
    LINEVALL_BUILD_TYPE := COMMUNITY
endif

# Test Build Tag
ifeq ($(LINEVALL_TEST),true)
    LINEVALL_BUILD_TYPE := DEVELOPER
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LINEVALL_BUILD_DATE_UTC := $(shell date -u '+%Y%m%d-%H%M')
BUILD_DATE_TIME := $(shell date -u '+%Y%m%d%H%M')

ifeq ($(LINEVALL_OFFICIAL), true)
   LIST = $(shell cat vendor/linevall/linevall.devices)
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      LINEVALL_BUILD_TYPE := RELEASE

#include vendor/linevall-priv/keys.mk
PRODUCT_PACKAGES += \
    Updater

    endif
    ifneq ($(IS_OFFICIAL), true)
       LINEVALL_BUILD_TYPE := COMMUNITY
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

ifeq ($(BUILD_WITH_GAPPS),true)
LINEVALL_EDITION := GAPPS
else
LINEVALL_EDITION := Vanilla
endif

ifeq ($(LINEVALL_EDITION), GAPPS)
LINEVALL_VERSION := LineVallOS-$(LINEVALL_MOD_VERSION)-$(CURRENT_DEVICE)-$(LINEVALL_EDITION)-$(LINEVALL_BUILD_TYPE)-$(LINEVALL_BUILD_DATE_UTC)
LINEVALL_FINGERPRINT := LineVallOS/$(LINEVALL_MOD_VERSION)/$(PLATFORM_VERSION)/$(LINEVALL_BUILD_DATE_UTC)
LINEVALL_DISPLAY_VERSION := LineVallOS-$(LINEVALL_MOD_VERSION)-$(LINEVALL_BUILD_TYPE)
else
LINEVALL_VERSION := LineVallOS-$(LINEVALL_MOD_VERSION)-$(CURRENT_DEVICE)-$(LINEVALL_BUILD_TYPE)-$(LINEVALL_BUILD_DATE_UTC)
LINEVALL_FINGERPRINT := LineVallOS/$(LINEVALL_MOD_VERSION)/$(PLATFORM_VERSION)/$(LINEVALL_BUILD_DATE_UTC)
LINEVALL_DISPLAY_VERSION := LineVallOS-$(LINEVALL_MOD_VERSION)-$(LINEVALL_BUILD_TYPE)
endif

TARGET_PRODUCT_SHORT := $(subst linevall_,,$(LINEVALL_BUILD))

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.linevall.version=$(LINEVALL_VERSION) \
  ro.linevall.releasetype=$(LINEVALL_BUILD_TYPE) \
  ro.modversion=$(LINEVALL_MOD_VERSION) \
  ro.linevall.display.version=$(LINEVALL_DISPLAY_VERSION) \
  ro.linevall.fingerprint=$(LINEVALL_FINGERPRINT) \
  ro.build.datetime=$(BUILD_DATE_TIME) \
  ro.linevall.edition=$(LINEVALL_EDITION)