#include <Preferences/PSSpecifier.h>
#include <Preferences/PSListController.h>
#import "MobileGestalt.h"

@interface PSGAboutController : PSListController
-(id)specifierWithName:(NSString *)name value:(NSString *)value isCopyable:(BOOL)isCopyable;
@end

%hook PSGAboutController
%new
-(id)specifierWithName:(NSString *)name value:(NSString *)value isCopyable:(BOOL)isCopyable {
	PSSpecifier *specifier = [%c(PSSpecifier) new];
	specifier.identifier = name;
	specifier.name = name;
	specifier.target = self;
	[specifier setProperty:value forKey:@"value"];
	[specifier setProperty:[NSNumber numberWithBool:isCopyable] forKey:@"isCopyable"];
	specifier.cellType = 4;
	return specifier;
}

-(void)viewWillAppear:(BOOL)arg1 {
	%orig;
	[self removeSpecifierID:@"SETTINGS_UDID" animated:NO];
	[self insertSpecifier:[self specifierWithName:@"SETTINGS_UDID" value:nil isCopyable:TRUE] afterSpecifierID:@"SerialNumber" animated:NO];
}

- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	PSTableCell *cell = %orig;

	if ([cell.specifier.identifier isEqualToString:@"SETTINGS_UDID"]) {
		cell.textLabel.text = @"UDID";
		cell.detailTextLabel.text = (NSString*) MGCopyAnswer(CFSTR("UniqueDeviceID"));
	}

	return cell;	
}

-(void)performSpecifierUpdates:(id)arg1 {
}
%end
