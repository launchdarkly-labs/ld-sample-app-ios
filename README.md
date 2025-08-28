# LaunchDarkly Sample App for iOS (Swift)

## Requirements

* Xcode 16 or higher
* LaunchDarkly Flags:
  - **First Feature**, key: `first-feature`
  - **Second Feature**, key: `second-feature`
  - **Third Feature**, key: `third-feature`

## Setup

To get started, clone this repo locally

```
git clone https://github.com/launchdarkly-labs/ld-sample-app-ios.git
cd ld-sample-app-ios
```

Add LaunchDarkly keys

* Rename `LDSampleAppiOS/Config.xcconfig.example` to `LDSampleAppiOS/Config.xcconfig`
* In the `LDSampleAppiOS/Config.xcconfig` file, replace the fake mobile key with your LaunchDarkly mobile key

In Xcode, open LDSampleAppiOS.xcodeproj


## Run

To run the app:

* In Xcode, navigate in the menu to Product->Run

Enjoy!
