#import "src/VscoPlus.h"

// This function will run whenever a window becomes the key (active) window.
static void handleKeyWindow(NSNotification *notification) {
    // We only want to add the button once, so we check our global flag.
    if (floatingButtonAdded) {
        return;
    }

    // Get the window object from the notification.
    UIWindow *window = notification.object;

    // Make sure we have a valid window.
    if (window && [window isKindOfClass:[UIWindow class]]) {
        VscoPlusFloatingButton *button = [[VscoPlusFloatingButton alloc] init];
        [window addSubview:button];
        
        // Set the flag to true so this code doesn't run again.
        floatingButtonAdded = YES;
    }
}

// A "%ctor" is a constructor that runs automatically when the tweak is injected.
// This is the perfect place to set up our notification listener.
%ctor {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIWindowDidBecomeKeyNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      handleKeyWindow(note);
                                                  }];
}