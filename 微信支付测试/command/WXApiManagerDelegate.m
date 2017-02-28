//
//  WXApiManagerDelegate.m
//  微信支付测试
//
//  Created by lushuishasha on 15/12/24.
//  Copyright © 2015年 lushuishasha. All rights reserved.
//

#if 1
#import "WXApiManagerDelegate.h"


@implementation WXApiManagerDelegate

#pragma mark - LifeCycle
+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    static WXApiManagerDelegate *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManagerDelegate alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
 if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}

@end
#endif