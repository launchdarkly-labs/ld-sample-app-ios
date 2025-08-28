//
//  ColorChanger.swift
//  LD Sample App iOS
//
//  Created by Kevin Cochran on 8/27/25.
//

import Foundation
import LaunchDarkly
import OSLog

class ColorChanger {
    var changer: ColorManager
    let client = LDClient.get()!

    init(changer: ColorManager) {
        self.changer = changer
        let flagKeys = ["first-feature", "second-feature", "third-feature"]
        flagKeys.forEach { flagKey in
            let updateColor = self.client.boolVariation(forKey: flagKey, defaultValue: false)
            if updateColor {
                self.makeGreen(flagKey: flagKey)
            } else {
                self.makeRed(flagKey: flagKey)
            }
        }
        self.client.observe(keys: flagKeys, owner: self) { changedFlags in
            changedFlags.keys.forEach { flagKey in
                guard case .bool(let booleanValue) = changedFlags[flagKey]?.newValue else { return }
                if booleanValue {
                    self.makeGreen(flagKey: flagKey)
                } else {
                    self.makeRed(flagKey: flagKey)
                }
            }
        }
    }
    
    func makeGreen(flagKey: String) {
        switch flagKey {
        case "first-feature":
            changer.cap1Color = .green
            return
        case "second-feature":
            changer.cap2Color = .green
            return
        case "third-feature":
            changer.cap3Color = .green
            return
        default:
            return
        }
    }
    
    func makeRed(flagKey: String) {
        switch flagKey {
        case "first-feature":
            changer.cap1Color = .red
            return
        case "second-feature":
            changer.cap2Color = .red
            return
        case "third-feature":
            changer.cap3Color = .red
            return
        default:
            return
        }
    }
}
