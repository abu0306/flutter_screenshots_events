import Flutter
import UIKit

public class SwiftFlutterScreenshotEventsPlugin: NSObject, FlutterPlugin,FlutterStreamHandler {

   var _eventSink:FlutterEventSink?

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_screenshots", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "flutter_screenshots/event", binaryMessenger: registrar.messenger())

        let instance = SwiftFlutterScreenshotEventsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)

        NotificationCenter.default.addObserver(instance, selector: #selector(instance.screenshots), name: UIApplication.userDidTakeScreenshotNotification, object: nil)

        if #available(iOS 11.0, *) {
            if UIScreen.main.isCaptured {
                instance.screenshots()
            }
            NotificationCenter.default.addObserver(instance, selector: #selector(instance.screenshots), name: UIScreen.capturedDidChangeNotification, object: nil)
        }
    }

    @objc func screenshots(){
        _eventSink?(true)
    }
}
