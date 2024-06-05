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
    
    var isLoginButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                
                Text("Surfspot")
                    .frame(maxWidth: .infinity)
                    .font(.title)
                    .bold()
                
                Spacer()
                
                if loginModel.errorMsg != "" {
                    Text(loginModel.errorMsg)
                }
                
                TextField("Email", text: $email)
                    .padding(10)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding(10)
                    .padding(.horizontal)
                
                NavigationLink("Create an account") {
                    SignupView()
                }
                    .padding(10)
                    .padding(.horizontal)
                
                Spacer()
                
                Button {
                    Task {
                        await loginModel.login(email, password)
                    }
                } label: {
                    Text("Login")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                }
                .frame(height: 50)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(isLoginButtonDisabled ? .gray : .blue)
                .cornerRadius(20)
                .disabled(isLoginButtonDisabled)
                .padding()
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
