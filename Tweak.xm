#import <UIKit/UIKit.h>
#define PLIST @"/var/mobile/Library/Preferences/am.theiostre.batteryshower.plist"

%hook SBUIController

-(BOOL)isOnAC {
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PLIST];
	
	if ([[dict objectForKey:@"Enabled"] boolValue]) {

		if ([[dict objectForKey:@"Battery"] boolValue]) {
			return YES;
		}
		else if (![[dict objectForKey:@"Battery"] boolValue]) {
			return NO;
		}
	}

	else {
		return %orig;
	}

}

%end