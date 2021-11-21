//
//  DetailView.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var device: Device
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea(.all)
            VStack{
                Text(device.friendlyName).titleStyle()
                Text("Hue").padding(.top)
                Slider(value: $device.hue, in: 0...255, onEditingChanged: self.updateDevice).padding([.leading, .bottom, .trailing])
                Text("Saturation").padding(.top)
                Slider(value: $device.sat, in: 0...255, onEditingChanged: self.updateDevice).padding([.leading, .bottom, .trailing])
                Text("Value").padding(.top)
                Slider(value: $device.val, in: 0...255, onEditingChanged: self.updateDevice).padding([.leading, .bottom, .trailing])
                Text("White").padding(.top)
                Slider(value: $device.white, in: 0...255, onEditingChanged: self.updateDevice).padding([.leading, .bottom, .trailing])
            }
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    init(device: Device){
        self.device = device
    }
    
    private func onAppear(){
        device.connect()
    }
    
    private func onDisappear(){
        device.disconnect()
    }
    
    private func updateDevice(changed: Bool){
        if(changed){
            device.sendState()
        }
    }
                  
}

/*struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(device: Device())
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
    
}*/
