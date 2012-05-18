include theos/makefiles/common.mk

TWEAK_NAME = BatteryShower
BatteryShower_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp BSPreferences.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BatteryShower.plist$(ECHO_END)
	$(ECHO_NOTHING)cp icon.png $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BatteryShower.png$(ECHO_END)