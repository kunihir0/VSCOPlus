#import "src/VscoPlus.h"

%hook VSCOImageDetailView
- (void)didMoveToWindow {
    %orig;
    if (self.window && ![self viewWithTag:1339]) {
        UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        downloadBtn.tag = 1339;
        [downloadBtn setTitle:@"Save" forState:UIControlStateNormal];
        [downloadBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        downloadBtn.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        downloadBtn.layer.cornerRadius = 18.0;
        downloadBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [downloadBtn addTarget:self action:@selector(saveImageTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downloadBtn];

        UIView *actionBar = self.actionBar;
        if (actionBar) {
            [NSLayoutConstraint activateConstraints:@[
                [downloadBtn.centerXAnchor constraintEqualToAnchor:actionBar.centerXAnchor],
                [downloadBtn.bottomAnchor constraintEqualToAnchor:actionBar.topAnchor constant:-15],
                [downloadBtn.widthAnchor constraintEqualToConstant:80],
                [downloadBtn.heightAnchor constraintEqualToConstant:36]
            ]];
        }
    }
}

- (void)layoutSubviews {
    %orig;
    UIButton *downloadBtn = (UIButton *)[self viewWithTag:1339];
    if (downloadBtn) {
        // All that complex animation logic is now just one clean function call!
        applyAnimatedGradientBorderToView(downloadBtn);
    }
}

%new
- (void)saveImageTapped {
    UIView *zoomingView = findFirstSubviewWithClassName(@"VSCOZoomingImageView", self);
    UIImageView *mainImageView = nil;
    if (zoomingView) {
        mainImageView = (UIImageView *)findFirstSubviewOfClass([UIImageView class], zoomingView);
    }
    
    if (mainImageView && mainImageView.image) {
        UIImageWriteToSavedPhotosAlbum(mainImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else {
        showToastNotificationWithText(@"Could not find image!");
    }
}

%new
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        showToastNotificationWithText([NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
    } else {
        showToastNotificationWithText(@"Saved to Photos! ✨");
    }
}
%end