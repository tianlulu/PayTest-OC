//
//  WXApiRuquestHandler.h
//  微信支付测试
//
//  Created by lushuishasha on 15/12/23.
//  Copyright © 2015年 lushuishasha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"

@interface WXApiRuquestHandler : NSObject
// 调起支付接口
+ (NSString *)jumpToBizPay;
@end
