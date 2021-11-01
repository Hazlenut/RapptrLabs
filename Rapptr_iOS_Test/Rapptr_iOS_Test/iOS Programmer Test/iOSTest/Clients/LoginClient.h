//
//  LoginClient.h
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import <Foundation/Foundation.h>

@interface LoginClient : NSObject
- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSDictionary *))completion;
@end
