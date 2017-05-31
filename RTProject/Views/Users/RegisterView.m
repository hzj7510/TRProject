//
//  RegisterView.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "RegisterView.h"
#import "RightBtnTextField.h"
#import "NSString+Base64Code.h"
#import "UIImage+FontAwesome.h"
#import "NSString+Re.h"

static const NSInteger backTime = 10;

@interface RegisterView ()
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

@property(nonatomic,strong)UIButton *getCodeBtn;
//电话号码输入框
@property(nonatomic,strong)RightBtnTextField *phoneNumTextField;
@end


@implementation RegisterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UIImageView *backImgView = [[UIImageView alloc]init];
    [self addSubview:backImgView];
    @weakify(self);
    [backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.mas_equalTo(self);
    }];
    
    self.phoneNumTextField = [[RightBtnTextField alloc]initWithFrame:CGRectZero With:DEFAULTTIGHTBTN];
    [self addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self).offset(64);
        make.left.mas_equalTo(self).mas_offset(50.0);
        make.right.mas_equalTo(self).mas_offset(-50.0);
        make.height.mas_equalTo(35);
    }];
    self.phoneNumTextField.backgroundColor = [UIColor lightGrayColor];
    
    RightBtnTextField *codeTextField = ({
        RightBtnTextField *view = [[RightBtnTextField alloc]initWithFrame:CGRectZero With:DEFAULTTIGHTBTN];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).offset(20);
            make.left.mas_equalTo(self).offset(20);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(35);
        }];
        view.backgroundColor = [UIColor lightGrayColor];
        view;
    });
    
    self.getCodeBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.mas_equalTo(codeTextField.mas_right).offset(10);
            make.right.mas_equalTo(self).offset(-20);
            make.top.mas_equalTo(codeTextField);
            make.height.mas_equalTo(codeTextField);
        }];
        [view setTitle:@"获取验证码" forState:UIControlStateNormal];
        view.backgroundColor = [UIColor redColor];
        view;
    });

    self.nextStepBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeTextField);
            make.right.mas_equalTo(self.getCodeBtn);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(codeTextField.mas_bottom).offset(20);
        }];
        [view setTitle:@"下一步" forState:UIControlStateNormal];
        view.backgroundColor = [UIColor blueColor];
        view;
    });
    
    [[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        __block NSInteger number = backTime;
        self.getCodeBtn.enabled = NO;
        //如果验证失败  提示错误返回
        @weakify(self);
        if (self.phoneNumTextField.text.length == 0 && ![self.phoneNumTextField.text rePhoneNum]) {
            @strongify(self);
            //提示错误
            self.getCodeBtn.enabled = YES;
        }else{
            //发送消息
            //伪代码
            BOOL request = YES;
            //如果发送失败
            if (!request) {
                //提示错误
                @strongify(self);
                self.getCodeBtn.enabled = YES;
            }else{
                //开始倒计时
                @weakify(self);
                [[[[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] take:backTime] startWith:@(1)]takeUntil:self.rac_willDeallocSignal]subscribeNext:^(id x){
                    @strongify(self);
                    //倒计时结束  重新获取验证码
                    if (0 == number) {
                        [self.getCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                        self.getCodeBtn.enabled = YES;
                    }
                    else{
                        self.getCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld 后重新发送", number--];
                    }
                }];
            }
        }
    }];
}
@end
