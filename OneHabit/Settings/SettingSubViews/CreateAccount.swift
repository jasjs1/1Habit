//  CreateAccount.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/25/23.
//

import SwiftUI
import Firebase

struct CreateAccount: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            
            Text("Create 1Habit Account")
                .font(.title2)
                .bold()
            
        
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: signup) {
                Text("Sign Up")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .font(.title3)
                    .bold()
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }

    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Signup error:", error.localizedDescription)
            } else {
                // Handle successful signup
                if let user = authResult?.user {
                    print("User signed up successfully:", user)
                }
            }
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
