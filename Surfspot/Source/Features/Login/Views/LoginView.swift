//
//  LoginView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginModel: LoginModel
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack(path: $loginModel.path) {
            Form {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                
                if loginModel.errorMsg != "" {
                    Text(loginModel.errorMsg)
                }
                
                Button("Login") {
                    Task {
                        await loginModel.login(email, password)
                    }
                }
                
                Text("Don't have an account?")
                NavigationLink("Create an account") {
                    SignupView()
                }
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
