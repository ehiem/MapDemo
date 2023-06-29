//
//  ContentView.swift
//  Map
//
//  Created by Scholar on 6/27/23.
//
import SwiftUI

struct ContentView : View {
    var body: some View {
        NavigationView {
            VStack {
                Text("This is the main page")
                NavigationLink(destination: MAP()) {
                    Text("Map")
                        .bold()
                        .background(Color.red)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
var body: some View {
    NavigationView {
        VStack {
            NavigationLink(destination: MAP()) {
                Text("Info")
                    .bold()
                    .background(Color.red)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MAP()
    }
}
