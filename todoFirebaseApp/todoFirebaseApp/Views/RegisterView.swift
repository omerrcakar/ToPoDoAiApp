//
//  RegisterView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import SwiftUI

struct RegisterView: View {

    
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 35){
                // Header
                HeaderView()
                // Register
                Form{
                    
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    Section(header: Text("Kayıt Formu")){
                        TextField("Tam Adınız", text: $viewModel.name)
                            .autocorrectionDisabled() // otomatik tamamlama kapat
                        TextField("Email",text: $viewModel.email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never) // baş harf büyütme kapat
                        SecureField("Şifre",text: $viewModel.password)
                    }
                }.scrollContentBackground(.hidden)
                    .frame(height: 300)
                
                BigButton(title: "Kayıt Ol") {
                    viewModel.register()
                }
                Spacer()
                
                
                
    
                
            }
        }
    }
}

#Preview {
    RegisterView()
}
