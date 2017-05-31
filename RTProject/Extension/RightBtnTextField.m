//
//  RightBtnTextField.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "RightBtnTextField.h"

@interface RightBtnTextField ()
@property(nonatomic, assign)FIELDRIGHTBTNTYPE type;
@end

@implementation RightBtnTextField

-(instancetype)initWithFrame:(CGRect)frame With:(FIELDRIGHTBTNTYPE)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UIView *placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.leftView = placeholderView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    if(self.type == DEFAULTTIGHTBTN){return;}
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn addTarget:self action:@selector(displayBookmarks:)
            forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.frame = CGRectMake(0, 0, 28, 28);
    
    self.rightView = self.rightBtn;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    switch (self.type) {
        case PASSWORDRIGHTBTN:{
            self.secureTextEntry = YES;
        }
            break;
            
        case SEARCHERRIGHTBTN:
            
            break;
            
        default:
            break;
    }
}

-(void)displayBookmarks:(UIButton *)sender{
    switch (self.type) {
        case PASSWORDRIGHTBTN:{
            sender.selected = !sender.selected;
            self.secureTextEntry = !sender.selected;
        }
            break;
            
        case SEARCHERRIGHTBTN:
            
            break;
            
        default:
            break;
    }
}

@end
