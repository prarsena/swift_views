//
//  SheetView.swift
//  lnxvm
//
//  Created by petera on 2/3/23.
//

import Foundation
import SwiftUI

struct SecView: View {
    let name: String

    var body: some View {
        Text("Hello, \(name)!")
    }
}

struct SheetView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecView(name: "Pete")
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
