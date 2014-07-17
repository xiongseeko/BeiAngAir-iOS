//
//  WifiInfo.m
//  BeiAngAir
//
//  Created by zhangbin on 7/11/14.
//  Copyright (c) 2014 BroadLink. All rights reserved.
//

#import "WifiInfo.h"

#define kWIFIs @"wifis"

@implementation WifiInfo

- (void)persistence
{
	if (self.SSID && self.password) {
		NSDictionary *wifis = [[NSUserDefaults standardUserDefaults] objectForKey:kWIFIs];
		NSMutableDictionary *new = wifis ? [NSMutableDictionary dictionaryWithDictionary:wifis] : [NSMutableDictionary dictionary];
		new[self.SSID] = self.password;
		[[NSUserDefaults standardUserDefaults] setObject:new forKey:kWIFIs];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (instancetype)wifiInfoWithSSID:(NSString *)SSID
{
	NSDictionary *wifis = [[NSUserDefaults standardUserDefaults] objectForKey:kWIFIs];
	if (wifis) {
		if (wifis[SSID]) {
			WifiInfo *info = [[WifiInfo alloc] init];
			info.SSID = SSID;
			info.password = wifis[SSID];
			return info;
		}
	}
	return nil;
}

@end