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
        
        logger.info("Mobile Key: \(Environment.mobileKey)")
        
        let config = LDConfig(mobileKey: Environment.mobileKey, autoEnvAttributes: .enabled)
        let ctx = ContextChanger()
        let context = ctx.getDeveloper()!

                        
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
