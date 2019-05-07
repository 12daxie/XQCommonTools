//
//  XQCommonTools+Permission.m
//  XQCommonTools
//
//  Created by Damon on 2018/2/15.
//  Copyright © 2018年 damon. All rights reserved.
//

#import "XQCommonTools+Permission.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>

NSString * const XQPermissionStatusDidChangeNotification = @"XQPermissionStatusDidChangeNotification";
NSString * const XQPermissionNameItem = @"XQPermissionNameItem";
NSString * const XQPermissionStatusItem = @"XQPermissionStatusItem";

CLLocationManager *locationManager;

@implementation XQCommonTools (Permission)

#pragma mark -
#pragma mark - 权限类

///是否有麦克风权限
//Whether have the microphone permissions
- (XQPrivatePermissionStatus)getAVMediaTypeAudioPermissionStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusAuthorized) {
        return kXQAuthorized;
    } else if (status == AVAuthorizationStatusNotDetermined) {
        return kXQNotDetermined;
    } else if (status == AVAuthorizationStatusRestricted) {
        return kXQAuthorRestricted;
    } else {
        return kXQDenied;
    }
}

///是否有拍照权限
//Whether have the Camera permissions
- (XQPrivatePermissionStatus)getAVMediaTypeVideoPermissionStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        return kXQAuthorized;
    } else if (status == AVAuthorizationStatusNotDetermined) {
        return kXQNotDetermined;
    } else if (status == AVAuthorizationStatusRestricted) {
        return kXQAuthorRestricted;
    } else {
        return kXQDenied;
    }
}

///是否有相册权限
////Whether have the Photo album permissions
- (XQPrivatePermissionStatus)getPhotoLibraryPermissionStatus {
    PHAuthorizationStatus status=[PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        return kXQAuthorized;
    } else if (status == PHAuthorizationStatusNotDetermined) {
        return kXQNotDetermined;
    } else if (status == PHAuthorizationStatusRestricted) {
        return kXQAuthorRestricted;
    } else {
        return kXQDenied;
    }
}

///是否有定位权限
//Whether have the GPS permissions
- (XQPrivatePermissionStatus)getGPSLibraryPermissionStatus {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus]  == kCLAuthorizationStatusAuthorizedAlways)) {
        //定位功能可用
        return kXQAuthorized;
    } else if ( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        return kXQNotDetermined;
    } else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusRestricted) {
        return kXQAuthorRestricted;
    } else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
        return kXQDenied;
    }
    return kXQDenied;
}

///是否有通知权限
///Whether there is notification authority
- (XQPrivatePermissionStatus)getNotificationPermissionStatus {
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
        return kXQDenied;
    } else {
        return kXQAuthorized;
    }
}

///申请定位权限
//Apply the GPS permissions
- (void)requestGPSLibraryPermissionWithType:(XQGPSPermissionType)GPSPermissionType {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if (GPSPermissionType == kXQGPSPermissionWhenInUse) {
        [locationManager requestWhenInUseAuthorization];
    } else if (GPSPermissionType == kXQGPSPermissionAlways) {
        [locationManager requestAlwaysAuthorization];
    } else if (GPSPermissionType == kXQGPSPermissionBoth) {
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
}

///申请麦克风权限
//Apply the Microphone permissions
- (void)requestAVMediaTypeAudioPermission {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        XQPrivatePermissionStatus permissionStatus;
        if (granted) {
            permissionStatus = kXQAuthorized;
        } else{
            permissionStatus = kXQDenied;
        }
        NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(kXQPermissionNameAudio),XQPermissionNameItem,@(permissionStatus),XQPermissionStatusItem, nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:XQPermissionStatusDidChangeNotification object:nil userInfo:userInfo];
    }];
}

///申请拍照权限
//Apply the Camera permissions
- (void)requestAVMediaTypeVideoPermission {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        XQPrivatePermissionStatus permissionStatus;
        if (granted) {
            permissionStatus = kXQAuthorized;
        } else {
            permissionStatus = kXQDenied;
        }
        NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(kXQPermissionNameVideo),XQPermissionNameItem,@(permissionStatus),XQPermissionStatusItem, nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:XQPermissionStatusDidChangeNotification object:nil userInfo:userInfo];
    }];
}

///申请相册权限
//Apply the Photo album permissions
- (void)requestPhotoLibraryPermission {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        XQPrivatePermissionStatus permissionStatus;
        if (status == PHAuthorizationStatusAuthorized) {
            permissionStatus = kXQAuthorized;
        } else if (status == PHAuthorizationStatusNotDetermined) {
            permissionStatus = kXQNotDetermined;
        } else if (status == PHAuthorizationStatusRestricted) {
            permissionStatus = kXQAuthorRestricted;
        } else {
            permissionStatus = kXQDenied;
        }
        NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(kXQPermissionNamePhotoLib),XQPermissionNameItem,@(permissionStatus),XQPermissionStatusItem, nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:XQPermissionStatusDidChangeNotification object:nil userInfo:userInfo];
    }];
}

///申请通知权限
///Application of notification authority
-(void)requestNotificationPermission {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
            XQPrivatePermissionStatus permissionStatus;
            if (granted) {
                permissionStatus = kXQAuthorized;
            } else {
                permissionStatus = kXQDenied;
            }
            NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(kXQPermissionNameNotification),XQPermissionNameItem,@(permissionStatus),XQPermissionStatusItem, nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:XQPermissionStatusDidChangeNotification object:nil userInfo:userInfo];
        }];
    } else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil]];  //注册通知
    }
}

///打开系统设置
//Open the system settings
- (void)openSystemSetting {
    NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:settingUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:settingUrl options:[NSDictionary dictionary] completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:settingUrl];
        }
    }
}

#pragma mark -
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    XQPrivatePermissionStatus permissionStatus;
    if (status == kCLAuthorizationStatusNotDetermined) {
        permissionStatus = kXQNotDetermined;
    } else if (status == kCLAuthorizationStatusRestricted) {
        permissionStatus = kXQAuthorRestricted;
    } else if (status == kCLAuthorizationStatusDenied) {
        permissionStatus = kXQDenied;
    } else {
        permissionStatus = kXQAuthorized;
    }
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(kXQPermissionNameGPS),XQPermissionNameItem,@(permissionStatus),XQPermissionStatusItem, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:XQPermissionStatusDidChangeNotification object:nil userInfo:userInfo];
}
@end
