//
//  HeaderView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 18.05.2024.
//

import SwiftUI


struct HeaderView: View {
    var body: some View {
        ZStack{
            Image("swordsman")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
            
            Text("ToDoApp")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .padding(.top, 200)
        }.padding(.top, 100)
    }
}

#Preview {
    HeaderView()
}
