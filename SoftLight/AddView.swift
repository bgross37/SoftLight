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
    
    @State private var ip = ""
    @State private var deviceType = ""
    @State private var friendlyName = ""
    
    var body: some View {
            VStack(alignment: .center, spacing: 20){
                Text("Add a Device").titleStyle()
                Section{
                    TextField("Address (192.168.1.10)", text: $ip)
                        .padding()
                    TextField("Name", text: $friendlyName)
                        .padding()
                }
                Button("Add device"){
                    let newDevice = Device(context: self.viewContext)
                    newDevice.ip = self.ip
                    newDevice.friendlyName = self.friendlyName
                    do{
                        try self.viewContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch{
                        print("Whoops \(error.localizedDescription)")
                    }
                }.buttonStyle(SoftLightButtonStyle(bgColor: Color("AccentColor")))
                Spacer()
            }.background(Color("background").edgesIgnoringSafeArea(.all))
            .opacity(0.8)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .preferredColorScheme(.dark)
    }
}
