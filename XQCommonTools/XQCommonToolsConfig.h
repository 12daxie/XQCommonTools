//
//  XQCommonToolsConfig.h
//  XQCommonTools
//
//  Created by Damon on 2018/2/15.
//  Copyright © 2018年 damon. All rights reserved.
//

#ifndef XQCommonToolsConfig_h
#define XQCommonToolsConfig_h

///申请的权限 Application authority
typedef NS_ENUM(NSUInteger, XQPrivatePermissionName) {
    kXQPermissionNameAudio,     //麦克风权限 Microphone permissions
    kXQPermissionNameVideo,     //摄像头权限 Camera permissions
    kXQPermissionNamePhotoLib,  //相册权限 Photo album permissions
    kXQPermissionNameGPS,       //GPS权限 GPS permissions
    kXQPermissionNameNotification, //通知权限 Notification permissions
};

///申请权限状态 Application permissions status
typedef NS_ENUM(NSUInteger, XQPrivatePermissionStatus) {
    kXQAuthorized = 1,  //用户允许 Authorized
    kXQAuthorRestricted,//被限制修改不了状态,比如家长控制选项等 Restricted status, such as parental control options, etc.
    kXQDenied,          //用户拒绝 Denied
    kXQNotDetermined    //用户尚未选择 NotDetermined
};

///申请定位权限的类型 The type of application for positioning permission
typedef NS_ENUM(NSUInteger, XQGPSPermissionType) {
    kXQGPSPermissionWhenInUse,      //申请使用期间访问位置 Access location WhenInUse
    kXQGPSPermissionAlways,         //申请一直访问位置  Always
    kXQGPSPermissionBoth            //两者都申请 Both
};

///常用的系统语言 Common system language
typedef NS_ENUM(NSUInteger, XQSystemLanguage) {
    kXQLanguageEn = 1,  //英文 English
    kXQLanguageTC,      //繁体中文 Traditional Chinese
    kXQLanguageCN,       //简体 Simplified Chinese
    kXQLanguageOther     //其他语言 Other languages
};

///时间戳快速转换为时间字符串 The time stamp is quickly converted to a time string
typedef NS_ENUM(NSUInteger, XQQuickFormatType) {
    kXQQuickFormateTypeYMD,         //年月日   2010-09-02
    kXQQuickFormateTypeMD,          //月日     09-02
    kXQQuickFormateTypeYMDTime,     //年月日时间 2010-09-02 05:23:17
    kXQQuickFormateTypeTime,        //时间    05:23:17
    kXQQuickFormateTypeMDTime,       //月日时间 09-02 05:23
    kXQQuickFormateTypeYMDTimeZone    //年月日时区 2018-03-15T09:59:00+0800
};

///
typedef NS_ENUM(NSUInteger, XQChineseLunarCalendarFormatType) {
    kXQChineseLunarCalendarFormatTypeYMD,         //年月日   2018年正月初十
    kXQChineseLunarCalendarFormatTypeMD,          //月日     正月初十
};

///评分样式类型 Scoring style type
typedef NS_ENUM(NSUInteger, XQScoreType) {
    kXQScoreTypeInAppStore,  //强制跳转到appsStore中评分。 Forced jump to appsStore
    kXQScoreTypeInApp,      //强制在app中弹出评分弹窗，ios10.3版本以下无反应。 Force the score pop-up window in app, the score will not respond when lower than the ios10.3 version
    kXQScoreTypeAuto         //10.3版本以下去appStore评分，10.3版本以上在app中弹出评分弹窗。jump to appsStore when lower than the ios10.3 version and the score pop-up window in app when higher than the ios10.3 version
};

///打开指定软件的appstore样式类型 Open the Appstore style type of the specified software
typedef NS_ENUM(NSUInteger, XQJumpStoreType) {
    kXQJumpStoreTypeInAppStore,  //强制跳转到appsStore。 Forced jump to appsStore
    kXQJumpStoreTypeInApp,      //强制在app中弹出appStore，ios10.3版本以下无反应。Force the score pop-up window in app, the score will not respond when lower than the ios10.3 version
    kXQJumpStoreTypeAuto         //10.3版本以下跳转appStore，10.3版本以上在app中弹出Appstore。jump to appsStore when lower than the ios10.3 version and the score pop-up window in app when higher than the ios10.3 version
};

///星座 Constellation
typedef NS_ENUM(NSUInteger, XQConstellation) {
    kXQConstellationCapricorn,      //摩羯座
    kXQConstellationAquarius,       //水瓶座
    kXQConstellationPisces,         //双鱼座
    kXQConstellationAries,          //白羊座
    kXQConstellationTaurus,         //金牛座
    kXQConstellationGemini,         //双子座
    kXQConstellationCancer,         //巨蟹座
    kXQConstellationLeo,            //狮子座
    kXQConstellationVirgo,          //处女座
    kXQConstellationLibra,          //天秤座
    kXQConstellationScorpio,        //天蝎座
    kXQConstellationSagittarius     //射手座
};

///十二生肖 Chinese Zodiac
typedef NS_ENUM(NSUInteger, XQChineseZodiac) {
    kXQChineseZodiacRat = 1,        //子鼠
    kXQChineseZodiacOx,         //丑牛
    kXQChineseZodiacTiger,      //寅虎
    kXQChineseZodiacRabbit,     //卯兔
    kXQChineseZodiacDragon,     //辰龙
    kXQChineseZodiacSnake,      //巳蛇
    kXQChineseZodiacHorse,      //午马
    kXQChineseZodiacGoat,       //未羊
    kXQChineseZodiacMonkey,     //申猴
    kXQChineseZodiacRooster,    //酉鸡
    kXQChineseZodiacDog,        //戌狗
    kXQChineseZodiacPig,        //亥猪
};
#endif /* XQCommonToolsConfig_h */
