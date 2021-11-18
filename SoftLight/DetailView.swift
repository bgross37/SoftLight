//
//  DetailView.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var websockethandler: WebSocketHandler
    
    @State private var hSliderValue: Double = 0
    @State private var sSliderValue: Double = 0
    @State private var vSliderValue: Double = 0
    @State private var wSliderValue: Double = 0
    
    let device: Device
    
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea(.all)
            VStack{
                Text(device.friendlyName ?? "--").titleStyle()
                Text("Hue").padding(.top)
                Slider(value: $hSliderValue, in: 0...255).padding([.leading, .bottom, .trailing])
                Text("Saturation").padding(.top)
                Slider(value: $sSliderValue, in: 0...255).padding([.leading, .bottom, .trailing])
                Text("Value").padding(.top)
                Slider(value: $vSliderValue, in: 0...255).padding([.leading, .bottom, .trailing])
                Text("White").padding(.top)
                Slider(value: $wSliderValue, in: 0...255).padding([.leading, .bottom, .trailing])
            }
        }
        .onAppear(perform: onAppear)
    }
    
    init(device: Device){
        self.device = device
        
    }
    
    private func onAppear(){
        //make sure WS is connected
    }
                  
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(device: PersistenceController.preview.container.viewContext.registeredObjects.first(where: { $0 is Device }) as! Device)
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
    
}
