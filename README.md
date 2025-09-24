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
* In the `LDSampleAppiOS/Config.xcconfig` file, replace the value of the following settings to your own values:
* * LD_MOBILE_KEY
* * LD_API_KEY
* * LD_PROJECT_KEY

In Xcode, open LDSampleAppiOS.xcodeproj

Now we need to make the application aware that there's something to read in that config file. Go to the project settings by clicking on the root **`LDSampleAppiOS`**.

* In the left-hand section, under **`TARGETS`**, click **LDSampleAppiOS**.
* In the main panel to the right, click on the middle tab labeled **Info**.
* In the **Custom iOS Target Properties** section, hover over any key, and to the right of the key name, click on the **`+`** to add a new key.
* Add the following keys and values:
* * **Key:** `LD_MOBILE_KEY`, **Value:** `$(LD_MOBILE_KEY)`
* * **Key:** `LD_API_KEY`, **Value:** `$(LD_API_KEY)`
* * **Key:** `LD_PROJECT_KEY`, **Value:** `$(LD_PROJECT_KEY)`

## Run

To run the app:

* In Xcode, navigate in the menu to Product->Run

Enjoy!
