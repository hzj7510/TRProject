//
//  RegisterPasswordView.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "RegisterPasswordView.h"
#import "RightBtnTextField.h"
#import "NSString+Base64Code.h"
#import "UIImage+FontAwesome.h"


@interface RegisterPasswordView ()
//密码输入框1
@property(nonatomic,strong)RightBtnTextField *pwdTextField1;
//密码输入框2
@property(nonatomic,strong)RightBtnTextField *pwdTextField2;
//提示框1
@property(nonatomic,strong)UILabel *tipLb1;
//提示框2
@property(nonatomic,strong)UILabel *tipLb2;
//确定按钮Command
@property(nonatomic,strong)RACCommand *sureCommand;
@end

@implementation RegisterPasswordView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    @weakify(self);
    self.pwdTextField1 = [[RightBtnTextField alloc]initWithFrame:CGRectZero With:PASSWORDRIGHTBTN];
    [self addSubview:self.pwdTextField1];
    [self.pwdTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self).offset(64.0);
        make.left.mas_equalTo(self).mas_offset(50.0);
        make.right.mas_equalTo(self).mas_offset(-50.0);
        make.height.mas_equalTo(35);
    }];
    [self.pwdTextField1.rightBtn setImage:[UIImage imageWithIcon:@"fa-eye-slash" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateNormal];
    [self.pwdTextField1.rightBtn setImage:[UIImage imageWithIcon:@"fa-eye" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateSelected];
    self.pwdTextField1.backgroundColor = [UIColor lightGrayColor];
    
    self.tipLb1 = ({
        UILabel *view = [UILabel new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(self.pwdTextField1.mas_bottom).offset(5);
            make.left.mas_equalTo(self.pwdTextField1);
            make.height.mas_greaterThanOrEqualTo(20);
            make.right.mas_equalTo(self.pwdTextField1);
        }];
        view.textColor = [UIColor redColor];
        view.font = [UIFont systemFontOfSize:13.0];
        view;
    });
    
    
    
    self.pwdTextField2 = [[RightBtnTextField alloc]initWithFrame:CGRectZero With:PASSWORDRIGHTBTN];
    [self addSubview:self.pwdTextField2];
    [self.pwdTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLb1.mas_bottom).offset(5.0);
        make.left.mas_equalTo(self).mas_offset(50.0);
        make.right.mas_equalTo(self).mas_offset(-50.0);
        make.height.mas_equalTo(35);
    }];
    self.pwdTextField2.backgroundColor = [UIColor lightGrayColor];
    [self.pwdTextField2.rightBtn setImage:[UIImage imageWithIcon:@"fa-eye-slash" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateNormal];
    [self.pwdTextField2.rightBtn setImage:[UIImage imageWithIcon:@"fa-eye" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateSelected];
    
    
    self.tipLb2 = ({
        UILabel *view = [UILabel new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(self.pwdTextField2.mas_bottom).offset(5);
            make.left.mas_equalTo(self.pwdTextField2);
            make.height.mas_greaterThanOrEqualTo(20);
            make.right.mas_equalTo(self.pwdTextField2);
        }];
        view.textColor = [UIColor redColor];
        view.font = [UIFont systemFontOfSize:13.0];
        view;
    });
    
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.tipLb2.mas_bottom).offset(5.0);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100.0);
        make.height.mas_equalTo(35);
    }];
    sureBtn.enabled = NO;
    
    RAC(sureBtn, enabled) = [RACSignal combineLatest:@[[[[self.pwdTextField1.rac_textSignal throttle:0.3]distinctUntilChanged]ignore:@""], [[self.pwdTextField2.rac_textSignal throttle:0.3]distinctUntilChanged]] reduce:^id(NSString *pwdtext1, NSString *pwdtext2){
        @strongify(self);
        if (pwdtext1.length >= 8 && pwdtext2.length >= 8 && [pwdtext1 isEqualToString:pwdtext2]) {
            self.tipLb2.text = @"";
            return @(YES);
        }else if(pwdtext1.length < 8){
            self.tipLb1.text = @"密码不能少于8位";
            self.tipLb2.text = @"";
            return @(NO);
        }else if(pwdtext2.length < 8){
            self.tipLb1.text = @"";
            self.tipLb2.text = @"密码不能少于8位";
            return @(NO);
        }else{
            self.tipLb1.text = @"";
            self.tipLb2.text = @"两次输入的密码不匹配";
            return @(NO);
        }
    }];
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        @strongify(self);
        
        NSString *pwd1 = self.pwdTextField1.text;
        NSString *pwd2 = self.pwdTextField2.text;
        if ([pwd1 isEqualToString:pwd2]) {
            //发送网络请求
            NSString *pwd1encode = [self.pwdTextField1.text base64EncodingString];
            NSString *pwd2encode = [self.pwdTextField2.text base64EncodingString];
            NSLog(@"密码1 ：%@ 密码2 ：%@", pwd1encode, pwd2encode);
        }else{
            //提示错误
            NSLog(@"%@密码错误", @"xxxx");
            
        }
    }];
}

@end
