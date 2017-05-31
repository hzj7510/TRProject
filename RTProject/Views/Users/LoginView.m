//
//  LoginView.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "LoginView.h"
#import "NSString+MD5.h"

@interface LoginView ()
@property(nonatomic,strong)UILabel *tipLb;
@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
    @weakify(self);
    UIImageView *backImgView = [[UIImageView alloc]init];
    [self addSubview:backImgView];
    [backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.mas_equalTo(self);
    }];
    
    UITextField *userNameTextField = [[UITextField alloc]init];
    [self addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self).mas_offset(50.0);
        make.left.mas_equalTo(self).mas_offset(-50.0);
        make.height.mas_equalTo(35);
    }];
    
    UITextField *pwdTextField = [[UITextField alloc]init];
    [self addSubview:pwdTextField];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(userNameTextField.mas_bottom).offset(20.0);
        make.left.mas_equalTo(self).mas_offset(50.0);
        make.left.mas_equalTo(self).mas_offset(-50.0);
        make.height.mas_equalTo(35);
    }];
    
    self.tipLb = ({
        UILabel *view = [UILabel new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(pwdTextField.mas_bottom).offset(5);
            make.left.mas_equalTo(pwdTextField);
            make.height.mas_greaterThanOrEqualTo(20);
            make.right.mas_equalTo(pwdTextField);
        }];
        view.textColor = [UIColor redColor];
        view.font = [UIFont systemFontOfSize:13.0];
        view;
    });
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pwdTextField.mas_bottom).offset(20.0);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(pwdTextField);
        make.height.mas_equalTo(35);
    }];
    
    RAC(sureBtn, enabled) = [[[[pwdTextField.rac_textSignal throttle:0.3]distinctUntilChanged]ignore:@""] map:^id(id value) {
        if (pwdTextField.text.length >= 8) {
            return @(YES);
        }else{
            return @(NO);
        }
    }];
    
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        //伪代码
        BOOL request = YES;
        //密码加密
        NSString *pwdMD5 = [pwdTextField.text md5b32];
        //如果发送失败
        if (!request) {
            //提示错误
        }else{
            //跳转到我的界面
        }
    }];
}

@end
