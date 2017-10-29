//
//  HHMainController.m
//  AliPay
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMainController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>






#define PARTNER    @"2088611922925773"
#define SELLER     @"esok@esok.cn"
#define URLSCHEME  @"alisdkpay"

#define PRIVATEKEY  @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANfEOGuHDyStqzetu37gO0Lxy9ucCVpT3t7oao/oYHyeQIhI4sxu7dnTbSdsR3DKglHg+9sNbIvubxxeLPvfjrF/Lvky0sYIGBRYyQXQb+kwOq0dwqHGvqN4FP1EwI69CfQP/a2J/z4D0stF/htv4B24dxag7mxZIKLJJvwstUbnAgMBAAECgYEAtVsDhTXPP6gNqs4HM3xrszgjfiIoJlkqkjfOIclTGEu3uBVzNBvlJdq0+5bicWZ1pTay2ors+qzdjX2G1+ovN2x9ZIZyVDL0P1CqgzwEu7hCIC5I/hlcMIux+h0U93stRxeimdCcbj2hCfzewE77hP4GQ6F4llzgDtvm9X41CYkCQQDy+63bcv7huWydUOuN7ObhOTAjoAe5SxJL89UkFkMGwJYqUm2cRNAkaJ3OPBBBXEeDpBjh323L6g0pUnM6q32lAkEA41NJY+GAXVUAWnAKNJHfXEi3XopnStsPRRL6gRCqTcceWEicq6CtyHEIxJuldiG0AP2u+Fh5faWx4phXKFEkmwJAFdGt2f/ojWJ2M2Y50MPOM7lL7lcHeocYPIPHxvbMzAVtNp2yRA8V1b8jNIrGNuhPb63DojzLAj2hMu25dTJDFQJAFi24CVCk73YtlKU9uadJvX0ytryWG02IDdsuKY1wsCnvIfnjnzMMAXRVwKjW2dGr+DTH717ia4nQ8ySdzEcuZQJAf1aGvpNuRP9Sf043ymPbhBVEb2bji6ltOr9R1VpCuaojP/EAYEAanzHLvcG+kc0QAk57+7hWp3smNQu+aYt1oQ=="





@interface HHMainController ()

@end

@implementation HHMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"main";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"付款" style:UIBarButtonItemStyleDone target:self action:@selector(payAction)];
    
}

- (void)payAction
{
   
//    服务端
//    负责生成订单及签名，及接受支付异步通知。
//    客户端
//    负责使用服务端传来的订单信息调用支付宝支付接口，及根据SDK同步返回的支付结果展示结果页。
//    服务端接入
//    私钥必须放在服务端，签名过程必须放在服务端。
    
     [self pay2];
    
}

- (void)pay2
{
    Order *order = [[Order alloc]init];
    order.partner = PARTNER;
    order.sellerID = SELLER;
    order.outTradeNO = @"201607181115";//订单Id
    order.subject = @"悦道用车";
    order.body = @"好评100%,实惠";//商品详情
    order.totalFee = @"0.01";
    order.notifyURL = @"www.baidu.com";//回调本服务器的
    order.service = @"mobile.securitypay.pay";//固定这些
    order.paymentType = @"1";//支付类型
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";//30分钟不购买订单取消
    
    NSString *appScheme = URLSCHEME ;//与info里一致
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PRIVATEKEY);
    NSString *signedString = [signer signString:orderSpec];
    
    
    NSString *orderString = nil;
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
    }
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        
        NSLog(@"---result:%@-----",resultDic);
        
    }];
    
}










@end
