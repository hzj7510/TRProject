//
//  RegisterViewController.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "RegisterPasswordViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RegisterView *registerView = [[RegisterView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
    [[registerView.nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        BOOL request = YES;
        //发送请求
        if (!request) {
            //提示错误
        }else{
            //界面跳转, 进入设置密码界面
            RegisterPasswordViewController *registerPwdViewController = [[RegisterPasswordViewController alloc]init];
            [self presentViewController:registerPwdViewController animated:YES completion:nil];
        }
    }];
}

@end
