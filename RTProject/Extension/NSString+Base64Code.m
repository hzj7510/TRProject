//
//  NSString+Base64Code.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "NSString+Base64Code.h"

@implementation NSString (Base64Code)

-(NSString *)base64EncodingString{
    NSString *pwd = [self stringByReversed:5];
    NSLog(@"%@", pwd);
    NSData *data = [pwd dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

-(NSString *)base64DecodingString{
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    NSString *pwd = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@" , [pwd stringByReversed:5]);
    
    return [pwd stringByReversed:5];
}

-(NSString *)stringByReversed:(int)count{
    const char *str = [self UTF8String];
    NSUInteger length = [self length];
    char *pReverse = (char*)malloc(length+1);//动态分配空间
    strcpy(pReverse, str);
    int i = 0, j = count;
    while (i < j) {
        char left = pReverse[i];
        pReverse[i] = pReverse[j];
        pReverse[j] = left;
        i += 1;
        j -= 1;
    }
    NSMutableString *pstr = [NSMutableString stringWithUTF8String:pReverse];
    free(pReverse);
    return [pstr copy];
}

@end
