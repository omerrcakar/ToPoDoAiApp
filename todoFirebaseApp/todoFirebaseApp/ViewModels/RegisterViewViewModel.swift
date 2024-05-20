//
//  RegisterViewViewModel.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel:ObservableObject{
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func register(){
        guard validate() else{
            
            return
        }
        
        // kullanıcıdan gelen email ve şifre kontrolden geçtikten sonra firebase e iletilme
        // [weak self] yapmamızdaki olay sayfanın bağlılığını azaltmak ve view modeli deinit() yaptığımızda memoryden silinmesini sağlar. Yanlış bilgi var ise düzeltirseniz sevinirim kolay gelsin.
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result, error in
            
            guard let userID = result?.user.uid else{
                return
            }
            
            // insert metodu çağırılacak
            
            self?.insertUserRecord(id: userID)
            
        }
    }
    
    private func insertUserRecord(id:String){
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool{
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Tüm alanları doldurmak bu kadar zor olmamalı!"
            return false
        }
        
        
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Kardeşim emailini düzgün yaz!"
            return false
        }
        
        guard password.count >= 6 else{
            errorMessage = "6 veya daha fazla karakterli bir şifre belirlesen mi acaba?"
            return false
        }
        
        
        return true
    }
    
}
