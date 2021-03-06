//
//  XQCommonTools+Date.m
//  XQCommonTools
//
//  Created by Damon on 2018/4/9.
//  Copyright © 2018年 damon. All rights reserved.
//

#import "XQCommonTools+Date.h"
#import "CalenderConverter.h"

@implementation ChineseLunarCalendar : NSObject
@end

@implementation XQCommonTools (Date)

///获取指定时间的时间戳
//Get the timestamp of the specified time
- (NSString *)getTimestampWitXQate:(NSDate *)date {
    return [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
}

///通过时间戳获取时间
///Get the Date by timestamp
- (NSDate *)getDateWithTimestamp:(NSString *)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    return date;
}

/**
 通过时间戳获取时间字符串
 Getting time through a timestamp
 
 @param timestamp 时间戳
 @param quickFormatType 快速格式化时间 Fast formatting time type
 you define foramatter
 @return 格式化过的时间
 */
- (NSString *)getTimeWithTimestamp:(NSString *)timestamp withQuickFormatType:(XQQuickFormatType)quickFormatType {
    NSDateFormatter *temp_formatter;
    switch (quickFormatType) {
        case kXQQuickFormateTypeYMD:{
            temp_formatter = [[NSDateFormatter alloc] init];
            [temp_formatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case kXQQuickFormateTypeMD:{
            temp_formatter = [[NSDateFormatter alloc] init];
            [temp_formatter setDateFormat:@"MM-dd"];
        }
            break;
        case kXQQuickFormateTypeYMDTime:{
            temp_formatter = [[NSDateFormatter alloc] init];
            [temp_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
            break;
        case kXQQuickFormateTypeTime:{
            temp_formatter = [[NSDateFormatter alloc] init];
            [temp_formatter setDateFormat:@"HH:mm:ss"];
        }
            break;
        case kXQQuickFormateTypeMDTime:{
            temp_formatter = [[NSDateFormatter alloc] init];
            [temp_formatter setDateFormat:@"MM-dd hh:mm"];
        }
            break;
        case kXQQuickFormateTypeYMDTimeZone:{
            temp_formatter = [[NSDateFormatter alloc] init];
            [temp_formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        }
            break;
    }
    
    NSDate* date = [self getDateWithTimestamp:timestamp];
    NSString* dateString = [temp_formatter stringFromDate:date];
    return dateString;
}

/**
 通过时间戳获取时间字符串
 Getting time through a timestamp
 
 @param timestamp 时间戳
 @param formatter 自己定义foramatter  you define foramatter
 @return 格式化过的时间
 */
- (NSString *)getTimeWithTimestamp:(NSString *)timestamp withCustomFormatter:(NSDateFormatter *)formatter {
    NSDate* date = [self getDateWithTimestamp:timestamp];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 比较两个日期的先后顺序
 Compare the order of the two dates
 
 @param firstDay 第一个日期
 @param secondDay 第二个日期
 @return 第一个日期和第二个日期比较的结果 the comparison between the first date and the second date
 NSOrderedAscending:第一个日期更早 The first date is earlier
 NSOrderedSame:两个日期一样 Two dates are the same
 NSOrderedDescending:第一个日期更晚 The first date is later
 */
- (NSComparisonResult)compareFirstDay:(NSDate *)firstDay withSecondDay:(NSDate *)secondDay withIgnoreTime:(BOOL)ignoreTime {
    if (![firstDay isKindOfClass:[NSDate class]]) {
        NSAssert(NO, @"firstDay类型错误! firstDay error in type!");
        return NSOrderedSame;
    }
    if (![secondDay isKindOfClass:[NSDate class]]) {
        NSAssert(NO, @"secondDay类型错误! secondDay error in type!");
        return NSOrderedSame;
    }
    if (!ignoreTime) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //格式化日期
        NSString *firstDayStr = [dateFormatter stringFromDate:firstDay];
        NSDate *dateA = [dateFormatter dateFromString:firstDayStr];
        
        NSString *secondDayStr = [dateFormatter stringFromDate:secondDay];
        NSDate *dateB = [dateFormatter dateFromString:secondDayStr];
        
        NSComparisonResult result = [dateA compare:dateB];
        return result;
    } else {
        NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
        [yearFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [yearFormatter setDateFormat:@"yyyy"];
        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
        [monthFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [monthFormatter setDateFormat:@"MM"];
        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
        [dayFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [dayFormatter setDateFormat:@"dd"];
        
        NSNumber *firstYearNum = @([[yearFormatter stringFromDate:firstDay] integerValue]);
        NSNumber *firstMonthNum = @([[monthFormatter stringFromDate:firstDay] integerValue]);
        NSNumber *firstDayNum = @([[dayFormatter stringFromDate:firstDay] integerValue]);
        
        NSNumber *secondYearNum = @([[yearFormatter stringFromDate:secondDay] integerValue]);
        NSNumber *secondMonthNum = @([[monthFormatter stringFromDate:secondDay] integerValue]);
        NSNumber *secondDayNum = @([[dayFormatter stringFromDate:secondDay] integerValue]);
        
        if ([firstYearNum integerValue] != [secondYearNum integerValue]) {
            return [firstYearNum  compare:secondYearNum];
        }
        if ([firstMonthNum integerValue] != [secondMonthNum integerValue]) {
            return [firstMonthNum  compare:secondMonthNum];
        }
        return [firstDayNum compare:secondDayNum];
    }
}

#pragma mark -
#pragma mark - 中国农历和公历转换、星座生肖

///通过时间获取中国农历的对象
- (ChineseLunarCalendar *)getChineseLunarCalendarWitXQate:(NSDate *)date {
    NSDateFormatter *temp_formatter = [[NSDateFormatter alloc] init];
    [temp_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [temp_formatter stringFromDate:date];
    NSArray *timeArray = [dateString componentsSeparatedByString:@"-"];
    return [self getChineseLunarCalendarWithYear:[[timeArray objectAtIndex:0] intValue] andMonth:[[timeArray objectAtIndex:1] intValue] andDay:[[timeArray objectAtIndex:2] intValue]];
}

///通过公历时间去创建中国农历的对象
- (ChineseLunarCalendar *)getChineseLunarCalendarWithYear:(int)year andMonth:(int)month andDay:(int)day {
    Solar *aSolar = [[Solar alloc] init];
    aSolar.solarYear = year;
    aSolar.solarMonth = month;
    aSolar.solarDay = day;
    Lunar *aLunar = [LunarSolarConverter solarToLunar:aSolar];
    
    ChineseLunarCalendar *chineseLunarCalendar = [[ChineseLunarCalendar alloc] init];
    chineseLunarCalendar.lunarYear = aLunar.lunarYear;
    chineseLunarCalendar.lunarMonth = aLunar.lunarMonth;
    chineseLunarCalendar.lunarDay = aLunar.lunarDay;
    chineseLunarCalendar.isleap = aLunar.isleap;
    return chineseLunarCalendar;
}

///通过农历的年月日获取中国农历对象
- (ChineseLunarCalendar *)getChineseLunarCalendarWithChineseLunarYear:(int)chineseLunaryear andChineseLunarMonth:(int)chineseLunarmonth andChineseLunarDay:(int)chineseLunarday andLeap:(BOOL)isleap {
    ChineseLunarCalendar *chineseLunarCalendar = [[ChineseLunarCalendar alloc] init];
    chineseLunarCalendar.lunarYear = chineseLunaryear;
    chineseLunarCalendar.lunarMonth = chineseLunarmonth;
    chineseLunarCalendar.lunarDay = chineseLunarday;
    chineseLunarCalendar.isleap = isleap;
    return chineseLunarCalendar;
}

///格式化农历的字符串
- (NSString *)getChineseLunarCalendarStrWithChineseLunarCalendar:(ChineseLunarCalendar *)chineseLunarCalendar withFormatType:(XQChineseLunarCalendarFormatType)chineseLunarCalendarFormatType {
    switch (chineseLunarCalendarFormatType) {
        case kXQChineseLunarCalendarFormatTypeYMD:{
            return [LunarSolarConverter formatlunarWithYear:chineseLunarCalendar.lunarYear AndMonth:chineseLunarCalendar.lunarMonth AndDay:chineseLunarCalendar.lunarDay];
        }
            break;
        case kXQChineseLunarCalendarFormatTypeMD:{
            return [LunarSolarConverter formatlunarWithMonth:chineseLunarCalendar.lunarMonth AndDay:chineseLunarCalendar.lunarDay];
        }
            break;
    }
}

///通过农历获取公历日期
- (NSDate *)getDateWithChineseLunarCalendar:(ChineseLunarCalendar *)chineseLunarCalendar {
    Lunar *lunar = [[Lunar alloc] init];
    lunar.lunarYear = chineseLunarCalendar.lunarYear;
    lunar.lunarMonth = chineseLunarCalendar.lunarMonth;
    lunar.lunarDay = chineseLunarCalendar.lunarDay;
    Solar *solar = [LunarSolarConverter lunarToSolar:lunar];
    NSString *dataStr = [NSString stringWithFormat:@"%d-%d-%d",solar.solarYear,solar.solarMonth,solar.solarDay];
    NSDateFormatter *temp_formatter = [[NSDateFormatter alloc] init];
    [temp_formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [temp_formatter dateFromString:dataStr];
    return date;
}

///通过农历获取生肖
- (XQChineseZodiac)getChineseZodiacWithYear:(int)year {
    int left = year%12 - 3;
    if (left < 0) {
        left = left + 12;
    }
    return left;
}

///通过日期获得星座
- (XQConstellation)getConstellationWitXQate:(NSDate *)date {
    NSString *ConstellationName = [LunarSolarConverter getXingzuo:date];
    if ([ConstellationName isEqualToString:@"摩羯座"]) {
        return kXQConstellationCapricorn;
    } else if ([ConstellationName isEqualToString:@"水瓶座"]) {
        return kXQConstellationAquarius;
    } else if ([ConstellationName isEqualToString:@"双鱼座"]) {
        return kXQConstellationPisces;
    } else if ([ConstellationName isEqualToString:@"白羊座"]) {
        return kXQConstellationAries;
    } else if ([ConstellationName isEqualToString:@"金牛座"]) {
        return kXQConstellationTaurus;
    } else if ([ConstellationName isEqualToString:@"双子座"]) {
        return kXQConstellationGemini;
    } else if ([ConstellationName isEqualToString:@"巨蟹座"]) {
        return kXQConstellationCancer;
    } else if ([ConstellationName isEqualToString:@"狮子座"]) {
        return kXQConstellationLeo;
    } else if ([ConstellationName isEqualToString:@"处女座"]) {
        return kXQConstellationVirgo;
    } else if ([ConstellationName isEqualToString:@"天秤座"]) {
        return kXQConstellationLibra;
    } else if ([ConstellationName isEqualToString:@"天蝎座"]) {
        return kXQConstellationScorpio;
    } else if ([ConstellationName isEqualToString:@"射手座"]) {
        return kXQConstellationSagittarius;
    }
    return kXQConstellationCapricorn;
}

@end
