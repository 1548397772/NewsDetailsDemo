//
//  HUD.m
//  NewsDetailsDemo
//
//  Created by 李响 on 2017/7/11.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "HUD.h"

// 背景视图的宽度/高度

#define BGVIEW_WIDTH 100.0f

// 文字大小

#define TEXT_SIZE    16.0f

// 显示时长

#define SHOWDURATION 1.5f

@implementation HUD

+ (instancetype)sharedHUD {
    
    static HUD *hud;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        hud = [[HUD alloc] initWithWindow:[HUD getMainWindow]];
    });
    
    return hud;
}

+ (void)showStatus:(MierProgressHUDStatus)status text:(NSString *)text {
    
    [[HUD getMainWindow] showStatus:status text:text];
}

#pragma mark - 推荐方法

+ (void)showMessage:(NSString *)text {
    
    [[HUD getMainWindow] showMessage:text];
}

+ (void)showInfoMsg:(NSString *)text {
    
    [[HUD getMainWindow] showStatus:MierProgressHUDStatusInfo text:text];
}

+ (void)showFailure:(NSString *)text {
    
    [[HUD getMainWindow] showStatus:MierProgressHUDStatusError text:text];
}

+ (void)showSuccess:(NSString *)text {
    
    [[HUD getMainWindow] showStatus:MierProgressHUDStatusSuccess text:text];
}

+ (void)showAddFavorites:(NSString *)text{
    
    [[HUD getMainWindow] showStatus:MierProgressHUDStatusStar text:text];
}

+ (void)showRemoveFavorites:(NSString *)text{
    
    [[HUD getMainWindow] showStatus:MierProgressHUDStatusHollowStar text:text];
}

+ (void)showLoading:(NSString *)text {
    
    [[HUD getMainWindow] showStatus:MierProgressHUDStatusWaitting text:text];
}

+ (void)hide {
    
    [[HUD sharedHUD] hide:YES];
}

+ (UIWindow *)getMainWindow{
    
    return [[UIApplication sharedApplication].delegate window];
}

@end

@implementation UIView (HUD)

- (void)showStatus:(MierProgressHUDStatus)status text:(NSString *)text{
    
    HUD *hud = [HUD sharedHUD];
    
    [hud removeFromSuperview];
    
    [hud setFrame:self.bounds];
    
    [hud show:YES];
    
    //    [hud setLabelText:text ? text : @""];
    
    [hud setDetailsLabelText:text ? text : @""];
    
    [hud setRemoveFromSuperViewOnHide:YES];
    
    //    [hud setLabelFont:[UIFont boldSystemFontOfSize:TEXT_SIZE]];
    
    [hud setDetailsLabelFont:[UIFont boldSystemFontOfSize:TEXT_SIZE]];
    
    [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    
    [self addSubview:hud];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"MierLoginSDKResources" ofType:@"bundle"];
    
    switch (status) {
            
        case MierProgressHUDStatusSuccess: {
            
            //            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"hud_success@2x.png"];
            //            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            UIImage *sucImage = [UIImage imageNamed:@"handle_success"];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            hud.customView = sucView;
            [hud hide:YES afterDelay:SHOWDURATION];
            [hud setUserInteractionEnabled:NO];
        }
            break;
            
        case MierProgressHUDStatusError: {
            
            //            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"hud_error@2x.png"];
            //            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            UIImage *errImage = [UIImage imageNamed:@"handle_fail"];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            hud.customView = errView;
            [hud hide:YES afterDelay:SHOWDURATION];
            [hud setUserInteractionEnabled:NO];
        }
            break;
            
        case MierProgressHUDStatusWaitting: {
            
            hud.mode = MBProgressHUDModeIndeterminate;
            [hud setUserInteractionEnabled:NO];
        }
            break;
            
        case MierProgressHUDStatusInfo: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            hud.customView = infoView;
            [hud hide:YES afterDelay:SHOWDURATION];
            [hud setUserInteractionEnabled:NO];
        }
            break;
            
        case MierProgressHUDStatusStar: {
            
            //            NSString *starPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
            //            UIImage *starImage = [UIImage imageWithContentsOfFile:starPath];
            UIImage *starImage = [UIImage imageNamed:@"collect_add"];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
            hud.customView = starView;
            [hud hide:YES afterDelay:SHOWDURATION];
            [hud setUserInteractionEnabled:NO];
        }
            break;
            
        case MierProgressHUDStatusHollowStar: {
            
            //            NSString *starPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
            //            UIImage *starImage = [UIImage imageWithContentsOfFile:starPath];
            UIImage *starImage = [UIImage imageNamed:@"collect_remove"];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
            hud.customView = starView;
            [hud hide:YES afterDelay:SHOWDURATION];
            [hud setUserInteractionEnabled:NO];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 在 view 上添加一个只显示文字的 HUD

- (void)showMessage:(NSString *)text{
    
    HUD *hud = [HUD sharedHUD];
    
    [hud show:YES];
    
    [hud setDetailsLabelText:text ? text : @""];
    
    [hud setMinSize:CGSizeZero];
    
    [hud setMode:MBProgressHUDModeText];
    
    [hud setRemoveFromSuperViewOnHide:YES];
    
    [hud setDetailsLabelFont:[UIFont boldSystemFontOfSize:TEXT_SIZE]];
    
    [hud setUserInteractionEnabled:NO];
    
    [self addSubview:hud];
    
    [hud hide:YES afterDelay:SHOWDURATION];
}

#pragma mark - 在 view 上添加一个提示`信息`的 HUD

- (void)showInfoMsg:(NSString *)text{
    
    [self showStatus:MierProgressHUDStatusInfo text:text];
}

#pragma mark - 在 view 上添加一个提示`失败`的 HUD

- (void)showFailure:(NSString *)text{
    
    [self showStatus:MierProgressHUDStatusError text:text];
}

#pragma mark - 在 view 上添加一个提示`成功`的 HUD

- (void)showSuccess:(NSString *)text{
    
    [self showStatus:MierProgressHUDStatusSuccess text:text];
}

#pragma mark - 在 view 上添加一个提示`收藏成功`的 HUD

- (void)showAddFavorites:(NSString *)text{
    
    [self showStatus:MierProgressHUDStatusStar text:text];
}

#pragma mark - 在 view 上添加一个提示`取消收藏`的 HUD

- (void)showRemoveFavorites:(NSString *)text{
    
    [self showStatus:MierProgressHUDStatusHollowStar text:text];
}

#pragma mark - 在 view 上添加一个提示`等待`的 HUD, 需要手动关闭

- (void)showLoading:(NSString *)text{
    
    [self showStatus:MierProgressHUDStatusWaitting text:text];
}

#pragma mark - 手动隐藏 HUD

- (void)hide{
    
    [[HUD sharedHUD] hide:YES];
}

@end
