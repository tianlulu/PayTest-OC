//
//  Product.h
//  微信支付测试
//
//  Created by lushuishasha on 15/12/25.
//  Copyright © 2015年 lushuishasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@end
