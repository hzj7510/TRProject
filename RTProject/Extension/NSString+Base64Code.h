//
//  NSString+Base64Code.h
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64Code)
//base64 编码
-(NSString *)base64EncodingString;
//base64 解码
-(NSString *)base64DecodingString;
@end
