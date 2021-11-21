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
    
    @EnvironmentObject var deviceCollection: DeviceCollection
    
    @State private var showingAddDevice = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack{
                    Text("SoftLight").padding(.top, -40).titleStyle()
                    List {
                        ForEach(deviceCollection.deviceCollection, id: \.ip) { device in
                            NavigationLink(destination: DetailView(device: device)) {
                                Text(device.friendlyName)
                            }
                        }
//                        .onDelete(perform: deleteItems)
                        
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
                        AddView().environment(\.managedObjectContext, self.viewContext).environmentObject(deviceCollection)
                    }
                }
            }
            .padding(-1.0)
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        
    }

    /*private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { deviceCollection[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
