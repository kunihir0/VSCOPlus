#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// --- Global State ---
static BOOL floatingButtonAdded = NO;

// --- FLEX Forward Declaration ---
@interface FLEXManager : NSObject
+ (instancetype)sharedManager;
- (void)showExplorer;
@end

// --- VscoPlus Interfaces ---
@class VscoPlusFloatingButton;

@interface VscoPlusMenuView : UIView
@property (nonatomic, weak) VscoPlusFloatingButton *presentingButton;
@end

@interface VscoPlusFloatingButton : UIView
@end

// --- App-Specific Interfaces ---
@interface VSCOImageDetailView : UIView
@property(nonatomic, strong) UIView *actionBar;
@property(nonatomic, strong) UIImageView *imageView;
@end

// --- Ad View Interfaces ---
@interface VSCONativeAdView : UIView
@end
@interface VSCONativeGoogleAdFeedCell : UICollectionViewCell
@end
@interface GADMediaView : UIView
@end
@interface GADWebView : UIView
@end
@interface GADOverlayView : UIView
@end

// --- Tweak Preferences ---
static inline BOOL isFlexEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isFlexEnabled_VscoPlus"];
}

static inline void setFlexEnabled(BOOL enabled) {
    [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"isFlexEnabled_VscoPlus"];
}

// --- Helper Function Declarations ---
void showToastNotificationWithText(NSString *text);
UIView* findFirstSubviewWithClassName(NSString *className, UIView *view);
UIView* findFirstSubviewOfClass(Class targetClass, UIView *view);
void applyAnimatedGradientBorderToView(UIView *view);