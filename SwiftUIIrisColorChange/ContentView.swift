//
//  ContentView.swift
//  SwiftUIIrisColorChange
//
//  Created by Pooya on 2021-03-08.
//

import SwiftUI

//Mark: -NavigationIndicator
struct NavigationIndicator : UIViewControllerRepresentable {
    typealias UIViewContollerType = ARView
    func makeUIViewController(context : Context) -> ARView {
        return ARView()
    }
    func updateUIViewController(_ uiViewContoller : NavigationIndicator.UIViewControllerType , context contrxt : UIViewControllerRepresentableContext<NavigationIndicator>) {}
}


struct ContentView: View {
    @State var page = "Home"
    
    var body: some View {
        VStack{
            if page == "Home" {
                Button("Switch to ARView"){
                    self.page = "ARView"
                }
            }
            else if page == "ARView" {
                ZStack {
                    NavigationIndicator()
                    VStack{
                        Spacer()
                        Spacer()
                        HStack {
                            Button("Home"){
                                self.page = "Home"
                            }.padding()
                            .background(RoundedRectangle(cornerRadius: 10) .foregroundColor(Color.white).opacity(0.7))
                            Button("Color") {
                                let irisColor = GlobalVar.irisnames.randomElement()!
                                print("changing color to \(irisColor) ")
                                GlobalVar.rightIriSName = irisColor
                                GlobalVar.leftIriSName = irisColor
                            }.padding()
                            .background(RoundedRectangle(cornerRadius: 10 ) .foregroundColor(Color.white).opacity(0.7))
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
