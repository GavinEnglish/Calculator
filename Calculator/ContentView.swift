//
//  ContentView.swift
//  Calculator
//
//  Created by 90305055 on 9/9/20.
//  Copyright © 2020 Gavin English. All rights reserved.
//

import SwiftUI



enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
case equals, plus, minus, multiply, divide
   case ac, plusMinus, percent
    case decimal
    
    var title: String {
        switch self {
        case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .plus: return "+"
            case .minus: return "-"
            case .percent: return "%"
            case .plusMinus: return "+/-"
            case .multiply: return "X"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .equals: return "="
            case .decimal: return "."
            case .divide: return "/"
            
        default:
            return "AC"
            
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color (.green)
        case .ac, .plusMinus, .percent:
            return .green
        default:
            return Color(.blue)
            
        }
    }
    
}

// Env object
class GlobalEnviornment: ObservableObject {
    
    @Published var display = "00"
    
    func receiveInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnviornment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
]
    
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
        
            VStack (spacing: 12) {

                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
            }.padding()
                
                
            ForEach(buttons, id: \.self) { row in
                HStack (spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(button: button)
                                                
                        }
                    }
                }
            }
        }.padding(.bottom)
        }
    }
 
    
    struct CalculatorButtonView: View {
        
        var button: CalculatorButton
        
        @EnvironmentObject var env: GlobalEnviornment
        
        var body: some View {
            Button(action: {
                self.env.receiveInput(calculatorButton: self.button)
            }) {
                    Text(button.title)
                    .font(.system(size: 32))
                    .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                    .foregroundColor(.white)
                    .background(button.backgroundColor)
                    .cornerRadius(self.buttonWidth(button: button))
                                      
                                  }
        }
        private func buttonWidth(button: CalculatorButton) -> CGFloat {
               if button == .zero {
                  return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
                   
               }
           return (UIScreen.main.bounds.width - 5 * 12) / 4
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviornment())
    }
}
}

