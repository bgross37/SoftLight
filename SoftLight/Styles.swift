//
//  Styles.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import SwiftUI

struct SoftLightButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
    }
}

struct ColorLibrary{
    static let mainColor = Color(hue: 0, saturation: 0, brightness: 0.5)
    static let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1c2839), Color(hex: 0x384455)]), startPoint: .top, endPoint: .bottom)
}


struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
