//
//  ProfileView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    init(){
        
    }
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 25){
                
                if let user = viewModel.user{
                    profile(user:user)
                }else{
                    Text("Kullanıcı Yükleniyor...")
                }
                
                
                
                // log out işlemi yapılacak - buton ekle
                BigButton(title: "Çıkış Yap"){
                    viewModel.logOut()
                }
                    
            }.navigationTitle("Profil")
                
        }.onAppear{
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user:User) -> some View{
        Image("role-model")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 125,height: 125)
        
        VStack(spacing: 25){
            HStack{
                Text("İsim :")
                Text(user.name)
            }.bold()
            HStack{
                Text("Email :")
                Text(user.email)
            }.bold()
            HStack{
                Text("Kayit Tarihi :")
                Text(Date(timeIntervalSince1970: user.joined).formatted(date:.abbreviated, time: .shortened))
            }.bold()
        }
    }
    
    
    
}

#Preview {
    ProfileView()
}
