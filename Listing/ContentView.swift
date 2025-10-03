//
//  ContentView.swift
//  Listing
//
//  Created by roma singh on 02/10/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let iosVersion = UIDevice.current.systemVersion

    var body: some View {
        VStack {
            Text("Current iOS Version:")
            Text(iosVersion)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
