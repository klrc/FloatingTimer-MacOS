//
//  ContentView.swift
//  floating timer
//
//  Created by Han Sun on 2023/12/1.
//

import SwiftUI



struct ContentView: View {
    
    @State var isFloating = false
    @State var isStart = false
    @State var duration:Int = 0
    @State var actionDuration:Int = 0
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    func formatPrints()-> String{
        let fsec = duration % 10
        let sec = (duration / 10) % 60
        let min = (duration / 600) % 60
        let hour = (duration / 36000) % 24
        return String(format:"%d:%02d:%02d.%d", hour, min, sec, fsec)
    }
    
    func onTimerSync(){
        if isStart {
            duration += 1
        }
        if actionDuration < 10{
            actionDuration += 1
        }
    }
    
    func onTapped(){
        if !isFloating{
            for window in NSApplication.shared.windows {
                window.level = .floating  // forced on top
            }
        }
        isStart.toggle()
        if actionDuration < 3 {
            duration = 0   // reset timer by double click
            isStart = false
            for window in NSApplication.shared.windows {
                window.level = .normal
            }
        }
        actionDuration = 0
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.formatPrints())
                .foregroundColor(Color.white)   // 字体颜色
                .font(.custom("Helvetica Neue", size: 48))
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .frame(width: 296, height: 72)
                .background(Color.black)
        }
        .onTapGesture {
            self.onTapped()
        }
        .onReceive(timer) { time in
            self.onTimerSync()
        }
    }
}


#Preview {
    ContentView()
}
