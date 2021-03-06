//
//  XQCommonTools+SystemInfo.h
//  XQCommonTools
//
//  Created by Damon on 2018/2/15.
//  Copyright © 2018年 damon. All rights reserved.
//

#import "XQBaseCommonTools.h"

@interface XQCommonTools (SystemInfo)
#pragma mark -
#pragma mark - 系统信息类
///软件版本
//the AppVersion
- (NSString *)getAppVersionStr;

///工程的build版本
//The build version of the project
- (NSString *)getAppBuildVersionStr;

///系统的ios版本
//The IOS version of the system
- (NSString *)getIOSVersionStr;

///获取系统语言
//Get the system language
- (NSString *)getIOSLanguageStr;

///是否是英文语言环境
//Is it an English language environment
- (BOOL)isEnglishLanguage;

///返回系统使用语言
//Return to the system usage language
- (XQSystemLanguage)getLanguage;

///软件Bundle Identifier
//Software Bundle Identifier
- (NSString *)getBundleIdentifier;

///模拟软件唯一标示，如果idfa可用使用idfa，否则则使用模拟的idfa
//The only indication of the simulation software.If IDFA is available, it will return to IDFA.Otherwise, use the analog IDFA
- (NSString *)getIphoneIdfa;

///获取具体的手机型号字符串
//Get a specific handset model string
- (NSString *)getDetailModelStr;

///是否是平板
//Whether is ipad
- (BOOL)isPad;

///是否是iphoneX
//Whether is iphoneX
- (BOOL)isPhoneX;
@end
