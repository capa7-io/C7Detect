#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/* Uncomment in order to test integrity check on C7DHandler */
/*
@interface FakeC7DHandler : NSObject

@end

@implementation FakeC7DHandler

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class c7DHandlerClass = NSClassFromString(@"C7DHandler");
        
        SEL originalSelector = @selector(onNotification:);
        SEL swizzledSelector = @selector(fake_onNotification:);
        
        Method originalMethod = class_getInstanceMethod(c7DHandlerClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(c7DHandlerClass,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(c7DHandlerClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)fake_onNotification:(NSNotification *)notification {
    NSLog(@"FakeC7DHandler: Captured Notification: %@", notification.name);
}
 
@end
*/
