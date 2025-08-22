#import "src/VscoPlus.h"

void applyAnimatedGradientBorderToView(UIView *view) {
    if (!view) return;

    const NSInteger borderViewTag = 99901;
    UIView *borderView = [view viewWithTag:borderViewTag];

    // --- ONE-TIME SETUP ---
    if (!borderView) {
        borderView = [[UIView alloc] init];
        borderView.tag = borderViewTag;
        borderView.clipsToBounds = YES;
        borderView.userInteractionEnabled = NO;
        [view insertSubview:borderView atIndex:0];

        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        
        // --- THIS IS THE KEY CHANGE ---
        // The color pattern is now duplicated to create a truly seamless loop.
        gradientLayer.colors = @[
            (id)[UIColor colorWithRed:1.00 green:0.00 blue:0.40 alpha:1.0].CGColor, // Magenta
            (id)[UIColor colorWithRed:0.40 green:0.00 blue:1.00 alpha:1.0].CGColor, // Purple
            (id)[UIColor colorWithRed:0.00 green:0.80 blue:1.00 alpha:1.0].CGColor, // Cyan
            (id)[UIColor colorWithRed:0.00 green:1.00 blue:0.40 alpha:1.0].CGColor, // Green
            (id)[UIColor colorWithRed:1.00 green:0.80 blue:0.00 alpha:1.0].CGColor, // Yellow
            (id)[UIColor colorWithRed:1.00 green:0.00 blue:0.40 alpha:1.0].CGColor  // Back to Magenta to complete the first cycle
        ];
        
        gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        [borderView.layer addSublayer:gradientLayer];

        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.lineWidth = 4.0;
        maskLayer.fillColor = [UIColor clearColor].CGColor;
        maskLayer.strokeColor = [UIColor blackColor].CGColor;
        borderView.layer.mask = maskLayer;
    }

    // --- ALWAYS UPDATE LAYOUT ---
    borderView.frame = view.bounds;
    borderView.layer.cornerRadius = view.layer.cornerRadius;

    CAGradientLayer *gradientLayer = (CAGradientLayer *)borderView.layer.sublayers.firstObject;
    gradientLayer.frame = CGRectMake(0, 0, view.bounds.size.width * 2, view.bounds.size.height);
    
    CAShapeLayer *maskLayer = (CAShapeLayer *)borderView.layer.mask;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderView.bounds cornerRadius:borderView.layer.cornerRadius].CGPath;

    // --- INTELLIGENTLY UPDATE ANIMATION ---
    CABasicAnimation *existingAnimation = (CABasicAnimation *)[gradientLayer animationForKey:@"slideAnimation"];
    CGFloat currentWidth = view.bounds.size.width;
    
    if (!existingAnimation || ![(NSNumber*)existingAnimation.toValue isEqualToNumber:@(-currentWidth)]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.fromValue = @(0);
        animation.toValue = @(-currentWidth);
        animation.duration = 3;
        animation.repeatCount = INFINITY;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.removedOnCompletion = NO;
        
        [gradientLayer addAnimation:animation forKey:@"slideAnimation"];
    }
}