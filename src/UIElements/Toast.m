#import "src/VscoPlus.h"

void showToastNotificationWithText(NSString *text) {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) return;

    UIView *toastView = [[UIView alloc] init];
    toastView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.85];
    toastView.layer.cornerRadius = 15.0;
    toastView.layer.shadowColor = [UIColor blackColor].CGColor;
    toastView.layer.shadowOffset = CGSizeMake(0, 2);
    toastView.layer.shadowOpacity = 0.3;
    toastView.layer.shadowRadius = 4.0;
    toastView.translatesAutoresizingMaskIntoConstraints = NO;

    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.translatesAutoresizingMaskIntoConstraints = NO;

    [toastView addSubview:label];
    [window addSubview:toastView];

    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:toastView.centerXAnchor],
        [label.centerYAnchor constraintEqualToAnchor:toastView.centerYAnchor],
        [toastView.leadingAnchor constraintEqualToAnchor:label.leadingAnchor constant:-20],
        [toastView.trailingAnchor constraintEqualToAnchor:label.trailingAnchor constant:20],
        [toastView.topAnchor constraintEqualToAnchor:label.topAnchor constant:-15],
        [toastView.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:15],
        [toastView.centerXAnchor constraintEqualToAnchor:window.centerXAnchor],
        [toastView.centerYAnchor constraintEqualToAnchor:window.centerYAnchor]
    ]];

    toastView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    toastView.alpha = 0.0;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toastView.alpha = 1.0;
        toastView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toastView.alpha = 0.0;
            toastView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
        }];
    }];
}