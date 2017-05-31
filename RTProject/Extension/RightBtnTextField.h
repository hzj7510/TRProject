//
//  RightBtnTextField.h
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DEFAULTTIGHTBTN = 0,
    PASSWORDRIGHTBTN,
    SEARCHERRIGHTBTN,
} FIELDRIGHTBTNTYPE;

@interface RightBtnTextField : UITextField

@property(nonatomic,strong) UIButton *rightBtn;

-(instancetype)initWithFrame:(CGRect)frame With:(FIELDRIGHTBTNTYPE)type;

@end
