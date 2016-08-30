#import "RJSync.h"

%hook AppDelegateiPhone

static BOOL syncButtonTapped = NO;

%new(B@:)
+(BOOL)isSyncButtonTapped {
	return syncButtonTapped;
}

%new(v@:)
+(void)setSyncButtonTapped:(BOOL)status {
	syncButtonTapped = status;
}

%end

%hook Prefs

+(BOOL)loggedIn {
	BOOL syncTapped = [%c(AppDelegateiPhone) isSyncButtonTapped];
	if (syncTapped) {
		[%c(AppDelegateiPhone) setSyncButtonTapped:NO];
		return YES;
	}
	return %orig;
}

%end

%hook MP3ActionsCelliPhone

- (void)syncPushed {
	[%c(AppDelegateiPhone) setSyncButtonTapped:YES];
	%orig;
}

%end

%hook VideoControlsCelliPhone

- (void)syncPushed {
	[%c(AppDelegateiPhone) setSyncButtonTapped:YES];
	%orig;
}

%end
