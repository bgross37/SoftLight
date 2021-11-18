//
//  ContentView.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Device.friendlyName, ascending: true)],
        animation: .default)
    private var devices: FetchedResults<Device>
    
    @State private var showingAddDevice = false
    
    @StateObject var websockethandler = WebSocketHandler()

    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack{
                    Text("SoftLight").padding(.top, -40).titleStyle()
                    List {
                        ForEach(devices) { device in
                            NavigationLink(destination: DetailView(device: device)) {
                                Text(device.friendlyName ?? "-")
                            }
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: { self.showingAddDevice.toggle() }) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showingAddDevice){
                        AddView().environment(\.managedObjectContext, self.viewContext)
                    }
                }
            }
            .padding(-1.0)
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        
        websockethandler.createWebsockets(devices: ["mirror.local"])
        websockethandler.connectAll()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { devices[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


//thoughts:
// OnAppear: tell WSHander to connect to ALL
// When clicking to DetailView, hand it the appropriate WS connection






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
