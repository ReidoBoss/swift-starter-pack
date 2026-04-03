//
//  UserView.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Factory
import Foundation
import SwiftUI

struct UserView: View {

    @Injected(\.userViewModel) var viewModel
    @Injected(\.sessionViewModel) var sessionViewModel

    var user: User? {
        viewModel.currentUser
    }

    var body: some View {
        VStack(spacing: 16) {
            nameSection
            logOutButton
        }
        .padding()
    }

    // MARK: - Subviews
    @ViewBuilder
    private var nameSection: some View {
        if let user {
            VStack(spacing: 4) {
                Text(user.firstName)
                    .font(.title)
                    .fontWeight(.semibold)
                Text(user.lastName)
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var logOutButton: some View {
        Button("Log Out") {
            sessionViewModel.delete()
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
    }
}
