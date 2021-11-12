//
//  SoftLightApp.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

@main
struct SoftLightApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
