//
//  ContentView.swift
//  LD Sample App iOS
//
//  Created by Kevin Cochran on 6/12/25.
//

import SwiftUI
import LaunchDarkly

class ColorManager: ObservableObject {
    @Published var cap1Color: Color = .red
    @Published var cap2Color: Color = .red
    @Published var cap3Color: Color = .red
}

struct ContentView: View {
    @StateObject var colorManager = ColorManager()
    let colorClass: ColorChanger
    let client: LDClient
    let crashTimes = 100
    
    @State private var buttonText = "Crash Now!"
    @State private var buttonDisabled = false
    @State private var selectedOption = "Developer"
    let options = ["Developer", "Customer", "Employee"]
    
    init() {
        let changer = ColorManager()
        _colorManager = StateObject(wrappedValue: changer)
        colorClass = ColorChanger(changer: changer)
        client = LDClient.get()!
    }
    
    var body: some View {
        VStack {
            Text("LaunchDarkly App")
                .font(.largeTitle)
            Image("cityscape")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                Capsule()
                    .fill(colorManager.cap1Color)
                    .frame(width: 50, height: 16)
                Text("First Feature")
                    .font(.system(size:24))
                Spacer()
            }
            .padding()
            HStack {
                Capsule()
                    .fill(colorManager.cap2Color)
                    .frame(width: 50, height: 16)
                Text("Second Feature")
                    .font(.system(size:24))
                Spacer()
            }
            .padding()
            HStack {
                Capsule()
                    .fill(colorManager.cap3Color)
                    .frame(width: 50, height: 16)
                Text("Third Feature")
                    .font(.system(size:24))
                Spacer()
            }
            .padding()
            Button(buttonText) {
                crashNow(counter: 0)
            }
            .font(.system(size:24, weight: .bold))
            .foregroundStyle(.red)
            .padding()
            .disabled(buttonDisabled)
            Spacer()
            Menu {
                Picker("Select an option", selection: $selectedOption) {
                    Text("Developer").tag("Developer")
                    Text("Customer").tag("Customer")
                    Text("Employee").tag("Employee")
                }
                .onChange(of: selectedOption) { oldOption, newOption in
                    changeUser(newOption)
                }
            } label: {
                Label(selectedOption, systemImage: "chevron.down.circle")
            }
        }
        .environmentObject(colorManager)
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .onDisappear() {
            client.stopObserving(owner: colorClass)
            client.observeFlagsUnchanged(owner: colorClass) {
                client.stopObserving(owner: colorClass as LDObserverOwner)
            }
            client.observeAll(owner: colorClass) {_ in
                client.stopObserving(owner: colorClass as LDObserverOwner)
            }
        }
    }
    
    func changeUser(_ selection: String) {
        let ctx = ContextChanger()
        
        switch selection {
        case "Developer":
            ctx.setDeveloper()
            break
        case "Customer":
            ctx.setCustomer()
            break
        case "Employee":
            ctx.setEmployee()
            break
        default:
            ctx.setDeveloper()
            break
        }
    }
    
    func crashNow(counter: Int32) {
        self.buttonDisabled = true
        self.buttonText = "Crashing..."
        while (counter < self.crashTimes) {
            let newUUID = UUID()
            let contextBuilder = LDContextBuilder(key: "user-" + newUUID.uuidString)
            var context: LDContext?
            
            do {
                context = try contextBuilder.build().get()
            } catch {
                
            }
            
            self.client.identify(context: context!) { result in
                let featureOne = self.client.boolVariation(forKey: "first-feature", defaultValue: false)
                if (featureOne) {
                    self.client.track(key: "error-rate")
                } else {
                    // do nothing
                }

                print(result)
                self.client.flush()
                print("Flushed!")
                crashNow(counter: counter + 1)
            }
            break
        }
        if (counter >= self.crashTimes) {
            self.buttonDisabled = false
            self.buttonText = "Crash Now!"
            changeUser(self.selectedOption)
        }
    }
}

#Preview {
    ContentView()
}

