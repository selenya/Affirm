//
//  ContentView.swift
//  Affirm
//
//  Created by Selen Yanar on 7.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    let timer = Timer.publish(every: 7, on: .main, in: .common).autoconnect()
    @State var background = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6475277543, green: 0.5764557719, blue: 0.6294283867, alpha: 1)),
                                                                       Color(#colorLiteral(red: 0.7164131403, green: 0.8667100668, blue: 0.8583627939, alpha: 1))]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
    @State private var fadeInOut = false
    
    var body: some View {
        Rectangle()
            .fill(background)
            .ignoresSafeArea()
            .onReceive(self.timer) { time in
                //Change background every second when timer triggered
                withAnimation(.linear(duration: 7)) {
                    fadeInOut.toggle()
                    self.background = changeBackgroundColor(topColor: getRandomColor(),
                                                            bottomColor: getRandomColor())
                    
                }
            }.opacity(fadeInOut ? 0 : 1)
    }
    
    func changeBackgroundColor(topColor: UIColor, bottomColor: UIColor) -> LinearGradient {
        self.background = LinearGradient(gradient: Gradient(colors: [Color(topColor),
                                                                     Color(bottomColor)]),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing)
        
        return background
    }
    
    
    func getRandomColor() -> UIColor {
        
        let colors = [#colorLiteral(red: 0.6475277543, green: 0.5764557719, blue: 0.6294283867, alpha: 1),#colorLiteral(red: 0.7882605791, green: 0.7882233858, blue: 0.8371105194, alpha: 1),#colorLiteral(red: 0.6384183168, green: 0.729480505, blue: 0.7047615647, alpha: 1),#colorLiteral(red: 0.460367918, green: 0.7215610743, blue: 0.7296198606, alpha: 1),#colorLiteral(red: 0.005418071058, green: 0.4743847847, blue: 0.5436778665, alpha: 1),#colorLiteral(red: 0.7164131403, green: 0.8667100668, blue: 0.8583627939, alpha: 1),#colorLiteral(red: 0.2163760066, green: 0.4784737825, blue: 0.4414744973, alpha: 1),#colorLiteral(red: 0.5776328444, green: 0.8667305708, blue: 0.8255947232, alpha: 1),#colorLiteral(red: 0.5776328444, green: 0.8667305708, blue: 0.8255947232, alpha: 1),#colorLiteral(red: 0.0744490996, green: 0.1214368269, blue: 0.1945256293, alpha: 1),#colorLiteral(red: 0.7751336694, green: 0.9021583796, blue: 0.7786861062, alpha: 1)]
        let randomColor = colors[Int.random(in: 0...10)]
        
        print("\(randomColor)")
        return randomColor
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
