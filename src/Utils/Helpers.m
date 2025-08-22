#import "src/VscoPlus.h"

UIView* findFirstSubviewOfClass(Class targetClass, UIView *view) {
    if (!view) return nil;
    if ([view isKindOfClass:targetClass]) {
        return view;
    }
    for (UIView *subview in view.subviews) {
        UIView *found = findFirstSubviewOfClass(targetClass, subview);
        if (found) {
            return found;
        }
    }
    return nil;
}

UIView* findFirstSubviewWithClassName(NSString *className, UIView *view) {
    if (!view) return nil;
    if ([NSStringFromClass([view class]) isEqualToString:className]) {
        return view;
    }
    for (UIView *subview in view.subviews) {
        UIView *found = findFirstSubviewWithClassName(className, subview);
        if (found) {
            return found;
        }
    }
    return nil;
}