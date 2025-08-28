//
//  Environment.swift
//  LDSampleAppiOS
//
//  Created by Kevin Cochran on 8/27/25.
//

import Foundation

public enum Environment {
    enum Keys {
        static let mobileKey = "LD_MOBILE_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found!")
        }
        return dict
    }()
    
    static let mobileKey: String = {
        guard let mobileKeyString = Environment.infoDictionary[Keys.mobileKey] as? String else {
            fatalError("LD_MOBILE_KEY not set in plist!")
        }
        return mobileKeyString
    }()
}
