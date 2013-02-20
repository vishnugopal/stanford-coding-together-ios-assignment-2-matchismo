//
//  CardGameSettings.h
//  Matchismo II
//
//  Created by Vishnu Gopal on 20/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardGameSettings : NSObject

+ (id)valueForKey:(NSString *)key;
+ (int)integerValueForKey:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;

@end
