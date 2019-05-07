//
//  XQCommonDefine.h
//  XQCommonTools
//
//  Created by Damon on 2018/2/23.
//  Copyright © 2018年 damon. All rights reserved.
//

/**
 *常用的宏定义CommonDefine
 *快捷实现常用功能
*/
#ifndef XQCommonDefine_h
#define XQCommonDefine_h

#pragma mark -
#pragma mark - 对象引用 Object reference
///弱引用 Weak reference
#define XQWEAKSELF __weak typeof(self) weakSelf = self
///强引用 Strong reference
#define XQSTRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf

#pragma mark -
#pragma mark - log输出
//log输出，当为true时输出log，false不输出log
//Log output, when log is output for true, false does not output log
#define XQDEBUG_MODE true

#if XQDEBUG_MODE
#define XQDebugLog( s, ... ) NSLog( @"XQDebugLog: \nFile: <%p %@:(%d)> \nFunction: %s\nLog: %@\n", __FILE__, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __FUNCTION__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define XQDebugLog( s, ... )
#endif

#pragma mark -
#pragma mark - 界面 Interface
/*
 *  UIColor
 */
///16进制颜色转为UIColor
///16 Decimal color turn to UIColor
#define XQColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
///16进制颜色转为UIColor，设置透明度
///16 Decimal color turn to UIColor with alpha
#define XQColorFromRGBA(rgbValue, _A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:_A]
///通过数值转为UIColor
///Turn to UIColor by numerical value
#define XQColorWithRGB(_R,_G,_B)        ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:1.0])
///通过数值转为UIColor，设置透明度
///Turn to UIColor by numerical value with alpha
#define XQColorWithRGBA(_R,_G,_B,_A)    ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A])
/*
 *  Screen size
 */
//屏幕宽度
//ScreenWidth
#define XQScreenWidth   [UIScreen mainScreen].bounds.size.width
//屏幕高度
//ScreenHeight
#define XQScreenHeight  [UIScreen mainScreen].bounds.size.height
//状态栏当前高度
//Status bar current height
#define XQ_Portrait_Status_Height [UIApplication sharedApplication].statusBarFrame.size.height //状态栏高度

// 判断是否是iPhone X
//Judge whether it is iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏默认高度
//Default height of State Bar
#define XQ_Default_Portrait_Status_Height (iPhoneX ? 44.f : 20.f)
// 导航栏默认高度
//Default height of the navigation bar
#define XQ_Default_Portrait_NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar默认高度
//Default height of the tabBar
#define XQ_Default_Portrait_TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define XQ_Default_Portrait_HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)
#endif /* XQCommonDefine_h */
