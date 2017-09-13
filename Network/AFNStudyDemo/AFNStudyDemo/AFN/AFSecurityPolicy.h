//
//  AFSecurityPolicy.h
//  AFNStudyDemo
//
//  Created by QD on 2017/9/13.
//  Copyright © 2017年 yudongdong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AFSSLPinningMode) {
    AFSSLPinningModeNone,
    AFSSLPinningModePublicKey,
    AFSSLPinningModeCertificate,
};


@interface AFSecurityPolicy : NSObject
//返回SSL Pinning的类型。默认的是AFSSLPinningModeNone。
@property (readonly, nonatomic, assign) AFSSLPinningMode SSLPinningMode;

// AFNetworking默认会搜索工程中所有.cer的证书文件。如果想制定某些证书，可使用certificatesInBundle在目标路径下加载证书，然后调用policyWithPinningMode:withPinnedCertificates创建一个本类对象。
@property (nonatomic, strong, nullable) NSSet <NSData *> *pinnedCertificates;
//使用允许无效或过期的证书，默认是不允许
@property (nonatomic, assign) BOOL allowInvalidCertificates;
//@property (nonatomic, assign) BOOL validatesDomainName;

@property (nonatomic, assign) BOOL validatesDomainName;
//返回指定bundle中的证书。如果使用AFNetworking的证书验证 ，就必须实现此方法，并且使用policyWithPinningMode:withPinnedCertificates 方法来创建实例对象。
+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;
//默认的实例对象，默认的认证设置为：
//1. 不允许无效或过期的证书

//2. 验证domain名称

//3. 不对证书和公钥进行验证
+ (instancetype)defaultPolicy;

+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode;

/**
 Creates and returns a security policy with the specified pinning mode.
 
 @param pinningMode The SSL pinning mode.
 @param pinnedCertificates The certificates to pin against.
 
 @return A new security policy.
 */
+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode withPinnedCertificates:(NSSet <NSData *> *)pinnedCertificates;


- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(nullable NSString *)domain;






















@end
