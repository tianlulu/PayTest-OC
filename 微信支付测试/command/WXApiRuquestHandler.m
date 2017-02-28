//
//  WXApiRuquestHandler.m
//  微信支付测试
//
//  Created by lushuishasha on 15/12/23.
//  Copyright © 2015年 lushuishasha. All rights reserved.
//

#import "WXApiRuquestHandler.h"
#import "WXApi.h"
#import "AFNetworking.h"

@implementation WXApiRuquestHandler
+ (NSString *)jumpToBizPay{

   // NSString *appid = @"wxc36f448e5bbe2922";
    NSString *noncestr = @"YEOBltxL0BhZST00a3eZQcP7zob9tjxQ";
    NSString *package = @"Sign=WXPay";
    NSString *partnerid = @"1244384002";
    NSString *prepayid = @"wx201512281845191c41d8f44c0453417704";
   // NSString *timestamp = @"1451299628";
    NSString *sign = @"6799FE7DB80A4142F8A4A9FAFDFC873E";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:noncestr forKey:@"noncestr"];
    [dict setObject:package forKey:@"package"];
    [dict setObject:partnerid forKey:@"partnerid"];
    [dict setObject:prepayid forKey:@"prepayid"];
    [dict setObject:@1451299628 forKey:@"timestamp"];
    [dict setObject:sign forKey:@"sign"];
    
//    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (dict != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
       // dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
       // NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[[PayReq alloc] init]autorelease];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
 
    
    
    
  /*
   //请求管理者
   AFHTTPRequestOperationManager *mgr  = [AFHTTPRequestOperationManager manager];
  
    //设置response的类型(决定了responseObject的返回值类型)
//    mgr.responseSerializer = [AFPropertyListResponseSerializer serializer];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
    //拼接请求参数
   NSMutableDictionary *params = [NSMutableDictionary dictionary];
   params[@"userid"] = @"1";
   params[@"order_jiner"] = @100;
  //http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios
   [mgr GET:@" http://developer.favourfree.com/index.php/AppV2_1/Money/wxpay_get_prepay_id" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       if (responseObject != nil) {
           NSLog(@"responseOnject:%@",responseObject);
//           NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//           dict = (NSMutableDictionary *)responseObject[@"data"];
               // NSMutableString *retcode = [dict objectForKey:@"retcode"];
               // if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                    //调起微信支付
//                    PayReq* req             = [[PayReq alloc] init];
//                    req.partnerId           = [dict objectForKey:@"partnerid"];
//                     NSLog(@"req.partnerId:%@",req.partnerId);
//                    req.prepayId            = [dict objectForKey:@"prepayid"];
//                    NSLog(@"prepayId:%@",req.prepayId);
//                    req.nonceStr            = [dict objectForKey:@"noncestr"];
//                    NSLog(@"nonceStr:%@",req.nonceStr);
//                    req.timeStamp           = stamp.intValue;
//                    NSLog(@"timeStamp:%d",req.timeStamp);
//                    req.package             = [dict objectForKey:@"package"];
//                    NSLog(@"package:%@",req.package);
//                    req.sign                = [dict objectForKey:@"sign"];
//           NSLog(@"sign:%@",req.sign);
//          //  NSLog(@"sign:%@",req.appid);
//                    [WXApi sendReq:req];
                }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"error:%@",error);
   }];
   return @"";
}
   */
    
}
@end
   
