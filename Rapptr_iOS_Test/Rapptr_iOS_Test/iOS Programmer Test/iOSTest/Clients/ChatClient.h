//
//  ChatClient.h
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import <Foundation/Foundation.h>
#import "Message.h"

@interface ChatClient : NSObject
- (void)fetchChatData:(void (^)(NSArray<Message *> *))completion withError:(void (^)(NSString *error))errorBlock;
@end
