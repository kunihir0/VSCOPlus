#import "src/VscoPlus.h"

@implementation VscoPlusFloatingButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(20, 100, 50, 50)];
    if (self) {
        self.backgroundColor = [UIColor systemBlueColor];
        self.layer.cornerRadius = 25;
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = @"V+";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:label];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)]];
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // This ensures the border is correctly sized whenever the layout changes,
    // for example, after being dragged to a new position.
    applyAnimatedGradientBorderToView(self);
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    UIWindow *window = self.window;
    CGPoint translation = [recognizer translationInView:window];
    self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:window];

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGRect windowBounds = window.bounds;
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeArea = window.safeAreaInsets;
            windowBounds = UIEdgeInsetsInsetRect(windowBounds, safeArea);
        }
        
        CGPoint velocity = [recognizer velocityInView:window];
        CGPoint target = self.center;
        target.x += velocity.x * 0.2;
        target.y += velocity.y * 0.2;
        
        if (target.x > windowBounds.size.width / 2) {
            target.x = windowBounds.origin.x + windowBounds.size.width - self.frame.size.width / 2 - 10;
        } else {
            target.x = windowBounds.origin.x + self.frame.size.width / 2 + 10;
        }
        target.y = MIN(MAX(target.y, windowBounds.origin.y + self.frame.size.height / 2), windowBounds.origin.y + windowBounds.size.height - self.frame.size.height / 2);
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.center = target;
        } completion:nil];
    }
}

- (void)showMenu {
    [self setHidden:YES];
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.window.bounds];
    dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.window addSubview:dimmingView];
    
    VscoPlusMenuView *menu = [[VscoPlusMenuView alloc] init];
    menu.presentingButton = self;
    [dimmingView addSubview:menu];
    
    [NSLayoutConstraint activateConstraints:@[
        [menu.centerXAnchor constraintEqualToAnchor:dimmingView.centerXAnchor],
        [menu.centerYAnchor constraintEqualToAnchor:dimmingView.centerYAnchor],
        [menu.widthAnchor constraintEqualToConstant:280]
    ]];
}
@end