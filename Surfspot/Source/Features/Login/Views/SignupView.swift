//
//  SignupView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var loginModel: LoginModel
    @Environment(\.dismiss) var dismiss
    
    @State var first_name = ""
    @State var last_name = ""
    @State var email = ""
    @State var password = ""
    
    var isSignupButtonDisabled: Bool {
        [first_name, email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Create an Account")
                .frame(maxWidth: .infinity)
                .font(.title2)
                .bold()
                .padding(20)
                .padding(.vertical)
            
            Spacer()
            
            if loginModel.errorMsg != "" {
                Text(loginModel.errorMsg)
            }
            
            TextField("First Name", text: $first_name)
                .padding(10)
                .padding(.horizontal)
            
            TextField("Last Name (Optional)", text: $last_name)
                .padding(10)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .padding(10)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .padding(10)
                .padding(.horizontal)
            
            Spacer()
            
            Button() {
                Task {
                    await loginModel.signup(first_name, last_name, email, password)
                    dismiss()
                }
            } label: {
                Text("Signup")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(isSignupButtonDisabled ? .gray : .blue)
            .cornerRadius(20)
            .disabled(isSignupButtonDisabled)
            .padding()
            
        }
    }

}

//#Preview {
//    SignupView()
//}
