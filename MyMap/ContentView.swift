//
//  ContentView.swift
//  MyMap
//
//  Created by みねた on 2022/02/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView(searchKey: "東京タワー")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
