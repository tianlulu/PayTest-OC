//
//  WXApiManagerDelegate.h
//  微信支付测试
//
//  Created by lushuishasha on 15/12/24.
//  Copyright © 2015年 lushuishasha. All rights reserved.
//

#if 1
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
@protocol WXApiManagerDelegate<NSObject>
@end


@interface WXApiManagerDelegate : NSObject<WXApiDelegate>
@property (nonatomic,assign) id<WXApiManagerDelegate>delegate;
+ (instancetype) shareManager;
@end
#endif