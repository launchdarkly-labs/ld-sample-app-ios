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
            Button("Crash Now") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .font(.system(size:24, weight: .bold))
            .foregroundStyle(.red)
            .padding()
            .hidden()
            Spacer()
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
}

#Preview {
    ContentView()
}

