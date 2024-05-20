//
//  LoginView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import SwiftUI

struct LoginView: View {
    
    //@State var email = ""
    //@State var password = ""
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        
        // sayfalar arası geçiş için gerekli
        NavigationStack{
            
            VStack(spacing: 25){
                // header
                HeaderView()
                
                // form , email password ve button
                
                Form{
                    // hata boş değilse yani hata varsa
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Email Adresiniz", text: $viewModel.email).bold()
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never) // baş harf büyütme kapat
                    
                    SecureField("Şifreniz", text: $viewModel.password).bold()
                }.frame(height: 200).scrollContentBackground(.hidden)
                
                BigButton(title: "Giriş Yap") {
                    viewModel.login()
                }
                Spacer()

                
                // footer
                
                VStack{
                    Text("Buralarda yabancısın heralde ?")
                        .bold()
                    NavigationLink("Yeni Hesap Oluştur",destination: RegisterView())
                        .bold()
                }.padding(.bottom, 30)
                
            }
            
        }
    }
}

#Preview {
    LoginView()
}
