//
//  ContentView.swift
//  AnimationSwiftUI
//
//  Created by Евгения Аникина on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green, Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
            VStack {
                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    .fill(.red, style: FillStyle(eoFill: true))
                
                Text("Потяни тут")
                Slider(value: $petalOffset, in: -40...40)
                    .padding([.horizontal, .bottom])
                
                Text("И теперь тут")
                Slider(value: $petalWidth, in: 0...100)
                    .padding(.horizontal)
            }
        }
    }
}

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

