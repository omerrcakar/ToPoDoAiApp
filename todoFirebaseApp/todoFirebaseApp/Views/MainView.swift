//
//  ContentView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        // giriş yapıldı ve boş değilse
        if viewModel.isSignedIn , !viewModel.currentUserId.isEmpty{
            accountView
            
            
        }else{
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View{
        TabView{
            ToDoListView(userID: viewModel.currentUserId)
                .tabItem {
                    Label("To Do", systemImage: "house")
                }
            
            PomodoroView()
                .tabItem {
                    Label("Pomodoro",systemImage: "alarm")
                }
            GeminiAIView()
                .tabItem {
                    Label("Help AI",systemImage: "message.badge.waveform")
                }
            ProfileView()
                .tabItem {
                    Label("Profile",systemImage: "person.circle")
                }
            
        }
    }
    
    
}

#Preview {
    MainView()
}
