//
//  LoginViewViewModel.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel:ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    
    func login(){
        
        guard validate() else{
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
        
    }
    
    // başındaki ve sonundaki boşlukları temizler.
    // email boşsa isempty ile true döner ve başındaki ! ile false olur ve else içine girer ve fonksiyondan çıkılır, fonksiyonu çalıştırmaz ( early çıkış)
    // return a girerse devamındaki kodlara bakmaz ve o fonksiyondan çıkar
    func validate() -> Bool{
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            // hata kısmı
            errorMessage = "Tüm alanları doldur be kardeşim!"
            return false
        }
        
        
        // geçerli email mi kontrolü
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Geçerli bir email yazmak bu kadar zor olmamalı!"
            return false
        }
        
        return true
    }
    
    
    
}
