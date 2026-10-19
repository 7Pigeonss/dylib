#import <UIKit/UIKit.h>

static NSInteger const kCenterDotOverlayTag = 0x43444f54;
static id<NSObject> gActivationObserver;

static UIWindow *CDActiveKeyWindow(void) {
    UIApplication *application = UIApplication.sharedApplication;
    for (UIScene *scene in application.connectedScenes) {
        if (![scene isKindOfClass:UIWindowScene.class]) {
            continue;
        }

        UIWindowScene *windowScene = (UIWindowScene *)scene;
        if (windowScene.activationState != UISceneActivationStateForegroundActive) {
            continue;
        }

        for (UIWindow *window in windowScene.windows) {
            if (window.isKeyWindow) {
                return window;
            }
        }
    }

    return nil;
}

static void CDInstallOverlay(void) {
    UIWindow *window = CDActiveKeyWindow();
    if (window == nil || [window viewWithTag:kCenterDotOverlayTag] != nil) {
        return;
    }

    UIView *overlay = [[UIView alloc] initWithFrame:window.bounds];
    overlay.tag = kCenterDotOverlayTag;
    overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlay.backgroundColor = UIColor.clearColor;
    overlay.userInteractionEnabled = NO;
    overlay.accessibilityElementsHidden = YES;

    CGFloat dotSize = 3.0;
    UIView *dot = [[UIView alloc] initWithFrame:CGRectMake(
        (CGRectGetWidth(overlay.bounds) - dotSize) / 2.0,
        (CGRectGetHeight(overlay.bounds) - dotSize) / 2.0,
        dotSize,
        dotSize
    )];
    dot.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleTopMargin
        | UIViewAutoresizingFlexibleBottomMargin;
    dot.backgroundColor = UIColor.blackColor;
    dot.layer.cornerRadius = dotSize / 2.0;
    dot.layer.masksToBounds = YES;

    [overlay addSubview:dot];
    [window addSubview:overlay];
}

__attribute__((constructor))
static void CDTweakLoad(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        gActivationObserver = [NSNotificationCenter.defaultCenter
            addObserverForName:UIApplicationDidBecomeActiveNotification
            object:nil
            queue:NSOperationQueue.mainQueue
            usingBlock:^(__unused NSNotification *notification) {
                CDInstallOverlay();
            }];
        CDInstallOverlay();
    });
}