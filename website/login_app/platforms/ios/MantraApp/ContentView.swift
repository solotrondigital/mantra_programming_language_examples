import SwiftUI

public struct ContentView: View {
    @State private var emailInput: String = ""
    @State private var passInput: String = ""
    @State private var rememberChk: Bool = false
    @State private var isLoggedIn: Bool = false

    public init() {}

    public var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text("🔐")
                            .font(.system(size: 48))
                        Text("login_app")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Built with Mantra Widgets • Native iOS SwiftUI")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Email Address").font(.caption).foregroundColor(.secondary)
                            TextField("name@example.com", text: $emailInput)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                                .keyboardType(.emailAddress)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password").font(.caption).foregroundColor(.secondary)
                            SecureField("••••••••", text: $passInput)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                        }

                        Button(action: {
                            isLoggedIn = true
                        }) {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(24)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 4)
                }
                .padding(20)
            }
        }
    }
}

#Preview {
    ContentView()
}

