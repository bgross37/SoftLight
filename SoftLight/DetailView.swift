//
//  DetailView.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

struct DetailView: View {
    @State private var wSliderValue: Double = 0
    
    let device: Device
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea(.all)
            VStack{
                Text(device.friendlyName ?? "--").titleStyle()
                Slider(value: $wSliderValue, in: 0...255).padding()
            }
        }
    }
    
    init(device: Device){
        self.device = device
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(device: PersistenceController.preview.container.viewContext.registeredObjects.first(where: { $0 is Device }) as! Device)
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
    
}
