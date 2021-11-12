//
//  DetailView.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(device: Device){
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(device: Device())
            .preferredColorScheme(.dark)
    }
}
