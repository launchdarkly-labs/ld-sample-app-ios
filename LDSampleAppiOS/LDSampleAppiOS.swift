//
//  LDSampleAppiOS.swift
//  LD Sample App iOS
//
//  Created by Kevin Cochran on 6/12/25.
//

import SwiftUI
import Foundation
import LaunchDarkly
import OSLog

@main
struct LDSampleAppiOS: App {
    init() {
        let logger = Logger()
//        guard let dict = Bundle.main.infoDictionary else {
//            fatalError("plist file not found!")
//        }
//        guard let mobileKey = dict["LD_MOBILE_KEY"] as? String else {
//            fatalError("LD_MOBILE_KEY not set in plist!")
//        }
        
        logger.info("Mobile Key: \(Environment.mobileKey)")
        
        let config = LDConfig(mobileKey: Environment.mobileKey, autoEnvAttributes: .enabled)

        var contextUserBuilder = LDContextBuilder()
        contextUserBuilder.kind("user")
        contextUserBuilder.key("user-018e7bd4-ab96-782e-87b0-b1e32082b481")
        contextUserBuilder.trySetValue("name", .string("Miriam Wilson"))
        contextUserBuilder.trySetValue("language", .string("en"))
        contextUserBuilder.trySetValue("tier", .string("premium"))
        contextUserBuilder.trySetValue("userId", .string("mwilson"))
        contextUserBuilder.trySetValue("role", .string("developer"))
        contextUserBuilder.trySetValue("email", .string("miriam.wilson@example.com"))
        
        var contextDeviceBuilder = LDContextBuilder()
        contextDeviceBuilder.kind("device")
        contextDeviceBuilder.key("device-018e7bd4-ab96-782e-87b0-b1e32082b481")
        contextUserBuilder.trySetValue("os", .string("macOS"))
        contextUserBuilder.trySetValue("osVersion", .string("15.6"))
        contextUserBuilder.trySetValue("model", .string("MacBook Pro"))
        contextUserBuilder.trySetValue("manufacturer", .string("Apple"))
        
        var contextBuilder = LDMultiContextBuilder()
        var context: LDContext
        
        do {
            contextBuilder.addContext(try contextUserBuilder.build().get())
            contextBuilder.addContext(try contextDeviceBuilder.build().get())
            context = try contextBuilder.build().get()
        } catch {
            return
        }
                        
        LDClient.start(config: config, context: context, startWaitSeconds: 5) { timedOut in
            if timedOut {
                // Client may not have the most recent flags for the configured context
            } else {
                // Client has received flags for the configured context
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
