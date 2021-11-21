//
//  AddView.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var deviceCollection: DeviceCollection


    
    @State private var ip = ""
    @State private var friendlyName = ""
    
    var body: some View {
            VStack(alignment: .center, spacing: 20){
                Text("Add a Device").titleStyle()
                Section{
                    TextField("Address (mirror.local, etc)", text: $ip)
                        .padding()
                    TextField("Name", text: $friendlyName)
                        .padding()
                }
                Button("Add device"){
                    addItem()
                }.buttonStyle(SoftLightButtonStyle(bgColor: Color("AccentColor")))
                Spacer()
            }.background(Color("background").edgesIgnoringSafeArea(.all))
            .opacity(0.8)
    }
    
    private func addItem(){
        deviceCollection.addItem(context: self.viewContext, ip: self.ip, friendlyName: self.friendlyName)
        self.presentationMode.wrappedValue.dismiss()
        do {
            try self.viewContext.save()
        } catch{
            print("Whoops \(error.localizedDescription)")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .preferredColorScheme(.dark)
    }
}
