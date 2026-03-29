//
//  ContentView.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Factory
import SwiftUI

struct ContentView: View {

    // MARK: - Dependency Injection
    //    @Injected(\)

    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
}
