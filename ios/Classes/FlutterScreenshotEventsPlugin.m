#import "FlutterScreenshotEventsPlugin.h"
#if __has_include(<flutter_screenshot_events/flutter_screenshot_events-Swift.h>)
#import <flutter_screenshot_events/flutter_screenshot_events-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_screenshot_events-Swift.h"
#endif

@implementation FlutterScreenshotEventsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterScreenshotEventsPlugin registerWithRegistrar:registrar];
}
@end
