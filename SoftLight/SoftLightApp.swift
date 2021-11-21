//
//  SoftLightApp.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

@main
struct SoftLightApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var deviceCollection: DeviceCollection
    
    let persistenceController = PersistenceController.shared
    
    init() {
        let deviceColectionTemp = DeviceCollection(managedObjectContext: persistenceController.container.viewContext)
        self._deviceCollection = StateObject(wrappedValue: deviceColectionTemp)
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(deviceCollection)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
                case .active:
                    print("App is active")
                    //reconnect websockets
                case .inactive:
                    print("App is inactive")
                    //disconnect websockets
                case .background:
                    print("App is in background")
                    //disconnect websockets
                @unknown default:
                    print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
