//
//  ContentView.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Factory
import SwiftUI

struct ContentView: View {

    @Injected(\.userViewModel) var userViewModel

    var currentUser: User? {
        userViewModel.currentUser
    }

    var body: some View {
        if currentUser != nil {
            UserView()
        } else {
            LoginView()
                .task {
                    userViewModel.find()
                }
        }

    }
}

#Preview {
    ContentView()
}
