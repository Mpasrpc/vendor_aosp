# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
ifneq ($(filter OFFICIAL,$(CUSTOM_BUILD_TYPE)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(TARGET_DEVICE)/$(TARGET_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.recovery_update=true
endif

# Branding
CUSTOM_BUILD_TYPE ?= UNOFFICIAL

# PixelPlusUI Props
PPUI_BASE_VERSION = 3.4
PPUI_CODENAME := Onyx

CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

CUSTOM_PLATFORM_VERSION := 11.0

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := PixelPlusUI_$(PPUI_BASE_VERSION)_$(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
CUSTOM_VERSION_PROP := eleven

ADDITIONAL_BUILD_PROPERTIES += \
    org.pixelplusui.version=$(PPUI_BASE_VERSION) \
    org.pixelplusui.version.display=$(CUSTOM_VERSION) \
    org.pixelplusui.build_date=$(CUSTOM_BUILD_DATE) \
    org.pixelplusui.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    org.pixelplusui.build_type=$(CUSTOM_BUILD_TYPE) \
    org.pixelplusui.codename=$(PPUI_CODENAME) \
    ro.pixelplusui.maintainer=$(PPUI_MAINTAINER)
