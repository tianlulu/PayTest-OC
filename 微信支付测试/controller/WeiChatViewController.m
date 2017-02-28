//
//  WeiChatViewController.m
//  微信支付测试
//
//  Created by lushuishasha on 15/12/24.
//  Copyright © 2015年 lushuishasha. All rights reserved.
//

#import "WeiChatViewController.h"
#import "WXApiRuquestHandler.h"
#import "WXApiManagerDelegate.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
//支付宝
#define PARTNER    @"2088811730483199"
#define SELLER     @"3086362508@qq.com"
#define PRIVATEKEY @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKS6tceFFId8X+IGEnxWiyNR+oEG5staeIsgr4/4onBnkWvh/NwqL4V6FesOhrzvFnsdxN+LGox8BnyimrvtK4o9i9PBgYvQsiZpWsdW6F9dlZs1PG9X6nnCsV1hjYMRxmOyGkvlVaDcQM8i2EY4pjrYcddxVKk8qIeUIL/mCpdFAgMBAAECgYEAiJ40/olXklpLZzgkAqz/7kYiHPptVP/uc2yjTiMmDVVH3RJq1OnDyc6L+QtuIamkmm0BB2jllteRxbJR5EP50/LqCb86h+wntXqWOkguExeYOczHBmYiKsbxfI6CahaKC5bx2ZsAQBqChqYCvOyz+EGYkAnj+3mP+qrDhHPnDqECQQDWuRerYjvw2HTYlR30R9+IBz/xtiYRjOkns6zTuEq4Yt53Iuq+dp9fS0U2+4Nll8lSZr/KdlN+xFN53iDgne55AkEAxGVWmFnl/Jxu2QAnuRwB02IfnLomwUALFlMUJ8hSSrPWsGIjK2mFMZGVWsU9Zhs3j25dooacQHtrjwrpLWoMLQJAR32Av/MI+ftXi/S58GctqWCgjZ2TtywvRKSx2hv15MYmQ4xAlAFytoudE91RtjV/Ngw3tvUGf6JmGKE4WRC8IQJBAL39JqtVdDZOgrEsBEF/hYifCOPN9QXH1bHwBrSBhpI7rTmOhmVNvAr6whhAbKglNjdr1esO+4MpoiCLto03ZLUCQBaX1z97G+s7/lH7rajfiWf+DRhbNKRN4rXgWGD98vTnE9iEC4egjxyexzM0SF8uWkhIRLrtv643073mECfxoik="
@interface WeiChatViewController()<WXApiManagerDelegate>
@property (nonatomic,strong) UITextField *priceTextField;
@end

@implementation WeiChatViewController
- (void)viewDidLoad {
    NSLog(@"1111111111111111111111111111");
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 400, 100, 50)];
    [button setTitle:@"微信支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(enterWeiChatPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [WXApiManagerDelegate shareManager].delegate = self;
    
    
    UIButton *Sbtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 400, 100, 50)];
    [Sbtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [Sbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Sbtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:Sbtn];
    [Sbtn addTarget:self action:@selector(enterZhiFuBao) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *BankBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 400, 100, 50)];
    [BankBtn setTitle:@"银联支付" forState:UIControlStateNormal];
    [BankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BankBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:BankBtn];
    [BankBtn addTarget:self action:@selector(enterBankPay) forControlEvents:UIControlEventTouchUpInside];
    
    self.priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.priceTextField.backgroundColor = [UIColor yellowColor];
    self.priceTextField.tintColor = [UIColor blackColor];
    self.priceTextField.placeholder = @"真不爽,又得给钱啦";
    [self.view addSubview:self.priceTextField];
    
}


//微信支付
#pragma mark -enterWeiChatPay
#if 1
- (void)enterWeiChatPay {
    NSString  *res = [WXApiRuquestHandler jumpToBizPay];
    if (![@"" isEqual:res]) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
}
#endif


#pragma mark -enterZhiFuBao
#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


//支付宝支付
- (void)enterZhiFuBao {
    NSLog(@"zhifubao");
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    Product *product = [[Product alloc]init];
    product.price = [self.priceTextField.text floatValue];
    product.body = @"喵喵，花钱啦，呜呜";
    product.subject = @"衣服";
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = PARTNER;
    NSString *seller = SELLER;
    NSString *privateKey = PRIVATEKEY;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = product.subject; //商品标题
    order.productDescription = product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL =  @"http://www.baidu.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于快捷支付成功后重新唤起商户应用
    NSString *appScheme = @"AlixPayDemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode(对订单进行加密)
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *str = @"";

            switch ([resultDic[@"resultStatus"] intValue]) {
                case 9000:
                    str = @"订单支付成功";
                    break;
                case 8000:
                    str = @"订单正在处理中";
                    break;
                case 4000:
                    str = @"订单支付失败";
                    break;
                case 6001:
                    str = @"用户中途取消支付";
                    break;
                case 6002:
                    str = @"网络连接出错";
                    break;
                    
                default:
                    break;
            }
            [self showAlertViewWith:nil message:str cancel:nil ensure:@"确定"];
            
        }];
        
        // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

}
- (void)showAlertViewWith:(id)object message:(NSString *)message cancel:(NSString *)cancelTitle ensure:(NSString *)ensureTitle{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:object
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:ensureTitle, nil];
    [alertView show];
    
}


#pragma mark -enterBankPay
//银联支付
- (void)enterBankPay {
    NSLog(@"银联");
    
//    NSString *recipients = @"mailto:ysy@flyrise.cn?subject=Hello from California!";
//    NSString *body = @"&body=It is raining in sunny California!";
//    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
//    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    
    NSString *num = @"13048844419"; //number为号码字符串
    NSString *mobileNumber = [NSString stringWithFormat:@"telprompt://%@", num];
    NSLog(@"call phone %@;", mobileNumber);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobileNumber]];
    
}



@end
