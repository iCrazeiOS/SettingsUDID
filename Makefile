ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Preferences

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SettingsUDID

SettingsUDID_FILES = Tweak.xm
SettingsUDID_LDFLAGS = -lmobilegestalt

include $(THEOS_MAKE_PATH)/tweak.mk
