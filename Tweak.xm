/*%%%%%
%% Tweak.xm
%% BatteryShower
%%
%% Based on iOS-ASB by Tyler Nettleton, licensed under the WTFPL.
%% Created by theiostream on 2011.
%%%%%*/

static NSDictionary *batteryPrefs = nil;
static void BSUpdatePrefs() {
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/am.theiostre.batteryshower.plist"];
	if (!plist) return;
	
	batteryPrefs = [plist retain];
}

static BOOL BSGetBoolPref(NSString *key, BOOL def) {
	if (!batteryPrefs) return def;

	NSNumber *v = [batteryPrefs objectForKey:key];
	return v ? [v boolValue] : def;
}
	
%hook SBAwayChargingView
+ (BOOL)shouldShowDeviceBattery {
	if (BSGetBoolPref(@"BSEnabled", YES))
		return BSGetBoolPref(@"BSBattery", YES);
	
	return %orig;
}
%end

%hook SBWallpaperView
- (float)alpha {
	if (BSGetBoolPref(@"BSAlpha", YES))
		return 0.0f;
		
	return %orig;
}
%end

static void BSReloadPrefs(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	BSUpdatePrefs();
}

%ctor {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];

	BSUpdatePrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &BSReloadPrefs, CFSTR("am.theiostre.batteryshower.reload"), NULL, 0);

	[pool drain];
}