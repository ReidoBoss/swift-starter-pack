//
//  LoginView.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Factory
import SwiftUI

struct LoginView: View {
    // MARK: - Dependencies
    @Injected(\.sessionViewModel) var sessionViewModel
    @Injected(\.userViewModel) var userViewModel

    // MARK: - State

    @State private var username: String = "emilys"
    @State private var password: String = "emilyspass"
    @State private var isPasswordVisible: Bool = false
    @FocusState private var focusedField: Field?

    var errorMessage: String? {
        sessionViewModel.errorMessage
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 24) {
            headerSection
            fieldsSection
            errorMessageSection
            loginButton
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .onTapGesture { focusedField = nil }
    }
}

// MARK: - Subviews

extension LoginView {
    fileprivate var errorMessageSection: some View {
        Group {
            if let message = errorMessage {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }
    fileprivate var headerSection: some View {
        VStack(spacing: 8) {
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            Text("Sign in to your account")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }

    fileprivate var fieldsSection: some View {
        VStack(spacing: 16) {
            usernameField
            passwordField
        }
    }

    fileprivate var usernameField: some View {
        TextField("Username", text: $username)
            .textContentType(.username)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .focused($focusedField, equals: .username)
            .submitLabel(.next)
            .onSubmit { focusedField = .password }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    fileprivate var passwordField: some View {
        HStack {
            Group {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
            }
            .textContentType(.password)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .focused($focusedField, equals: .password)
            .submitLabel(.go)
            .onSubmit { handleLogin() }

            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    fileprivate var loginButton: some View {
        Button(action: handleLogin) {
            Text("Sign In")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(username.isEmpty || password.isEmpty)
        .opacity(username.isEmpty || password.isEmpty ? 0.5 : 1)
        .buttonStyle(.plain)
    }
}

// MARK: - Actions

extension LoginView {

    fileprivate func handleLogin() {
        guard !username.isEmpty, !password.isEmpty else { return }
        focusedField = nil

        sessionViewModel
            .create(username: username, password: password)
    }
}

// MARK: - Focus Field

extension LoginView {

    fileprivate enum Field {
        case username
        case password
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
