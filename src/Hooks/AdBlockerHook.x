#import "src/VscoPlus.h"

// Block full-screen ads
%hook UIViewController
- (void)presentViewController:(UIViewController *)vc animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([NSStringFromClass([vc class]) isEqualToString:@"GADFullScreenAdViewController"]) {
        showToastNotificationWithText(@"Ad Blocked! ✨");
        return;
    }
    %orig(vc, flag, completion);
}
%end

// Block ad views and cells
%hook VSCONativeAdView
- (id)initWithFrame:(CGRect)frame {
    showToastNotificationWithText(@"Ad Blocked! ✨");
    return nil;
}
%end

%hook VSCONativeGoogleAdFeedCell
- (id)initWithFrame:(CGRect)frame {
    showToastNotificationWithText(@"Ad Blocked! ✨");
    return nil;
}
- (void)setHidden:(BOOL)hidden { %orig(YES); }
- (CGRect)frame { return CGRectZero; }
- (CGRect)bounds { return CGRectZero; }
%end

%hook GADMediaView
- (id)initWithFrame:(CGRect)frame { return nil; }
%end

%hook GADWebView
- (id)initWithFrame:(CGRect)frame { return nil; }
%end

%hook GADOverlayView
- (id)initWithFrame:(CGRect)frame { return nil; }
%end