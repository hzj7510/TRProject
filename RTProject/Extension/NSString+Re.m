//
//  NSString+Re.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "NSString+Re.h"

@implementation NSString (Re)

-(BOOL)rePhoneNum{
    NSString *matchStr = @"^1[358]\\d{9}$|^147\\d{8}$|^176\\d{8}$";
    NSRange searchedRange = NSMakeRange(0, [self length]);
    NSError *error = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: matchStr options:0 error:&error];
    NSArray* matches = [regex matchesInString:self options:0 range:searchedRange];
    
    return matches.count != 0;
}

@end
