//
//  XQCommonTools+Appstore.m
//  XQCommonTools
//
//  Created by Damon on 2018/2/16.
//  Copyright © 2018年 damon. All rights reserved.
//

#import "XQCommonTools+Appstore.h"

@implementation XQCommonTools (Appstore)

- (void)openAppStoreWithAppleID:(NSString *)appleID withType:(XQJumpStoreType)jumpStoreType {
    switch (jumpStoreType) {
        case kXQJumpStoreTypeInAppStore:{
            NSString* urlStr =[NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",appleID];
            [[XQCommonTools sharedXQCommonTools] applicationOpenURL:[NSURL URLWithString:urlStr]];
        }
            break;
        case kXQJumpStoreTypeInApp:{
            if (@available(iOS 10.3, *)) {
                SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
                storeProductVC.delegate = self;
                [storeProductVC loadProductWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:appleID,SKStoreProductParameterITunesItemIdentifier, nil] completionBlock:^(BOOL result, NSError * _Nullable error) {
                    if (result) {
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:storeProductVC animated:YES completion:nil];
                    } else {
                        NSLog(@"%@",error);
                    }
                }];
            } else {
                NSLog(@"Less than 10.3 version does not support opening the Appstore preview page within app");
            }
        }
            break;
        case kXQJumpStoreTypeAuto:{
            if (@available(iOS 10.3, *)) {
                SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
                storeProductVC.delegate = self;
                [storeProductVC loadProductWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:appleID,SKStoreProductParameterITunesItemIdentifier, nil] completionBlock:^(BOOL result, NSError * _Nullable error) {
                    if (result) {
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:storeProductVC animated:YES completion:nil];
                    } else {
                        NSLog(@"%@",error);
                    }
                }];
            } else {
                NSString* urlStr =[NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",appleID];
                [[XQCommonTools sharedXQCommonTools] applicationOpenURL:[NSURL URLWithString:urlStr]];
            }
        }
            break;
    }
}

- (void)giveScoreWithAppleID:(NSString *)appleID withType:(XQScoreType)scoreType {
    switch (scoreType) {
        case kXQScoreTypeInAppStore:{
            NSString* urlStr =[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=%@",appleID];
            [[XQCommonTools sharedXQCommonTools] applicationOpenURL:[NSURL URLWithString:urlStr]];
        }
            break;
        case kXQScoreTypeInApp:{
            if (@available(iOS 10.3, *)) {
                [SKStoreReviewController requestReview];
            } else {
                NSLog(@"Less than 10.3 version does not support the app open score");
            }
        }
            break;
        case kXQScoreTypeAuto:{
            if (@available(iOS 10.3, *)) {
                [SKStoreReviewController requestReview];
            } else {
                NSString* urlStr =[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appleID];
                [[XQCommonTools sharedXQCommonTools] applicationOpenURL:[NSURL URLWithString:urlStr]];
            }
        }
            break;
    }
}

- (void)giveScoreAutoTypeWithAppleID:(NSString *)appleID withHasRequestTime:(NSUInteger)hasRequestTime withTotalTimeLimit:(NSUInteger)totalTimeLimit {
    if (@available(iOS 10.3, *)) {
        if (hasRequestTime < totalTimeLimit && hasRequestTime < 3) {
            [SKStoreReviewController requestReview];
        } else {
            [self giveScoreWithAppleID:appleID withType:kXQScoreTypeInAppStore];
        }
    } else {
        [self giveScoreWithAppleID:appleID withType:kXQScoreTypeInAppStore];
    }
}

#pragma mark -
#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}
@end
