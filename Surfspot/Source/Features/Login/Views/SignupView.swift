//
//  SignupView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var loginModel: LoginModel
    
    @State var first_name = ""
    @State var last_name = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        Form {
            TextField("First Name", text: $first_name)
            TextField("Last Name", text: $last_name)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            if loginModel.errorMsg != "" {
                Text(loginModel.errorMsg)
            }
            
            Button("Signup") {
                Task {
                    await loginModel.signup(first_name, last_name, email, password)
                }
            }
            
        }
    }
}

//#Preview {
//    SignupView()
//}
