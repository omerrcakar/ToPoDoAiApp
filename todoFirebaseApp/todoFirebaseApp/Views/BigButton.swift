//
//  BigButton.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 18.05.2024.
//

import SwiftUI

struct BigButton: View {
    
    let title :String
    let action : () -> Void
    
    var body: some View {
        
        Button(action: action, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.secondary)
                Text(title).foregroundStyle(.white).bold()
            }
        }).frame(height: 50)
            .padding(.horizontal)
    }
}

#Preview {
    BigButton(title: "Deneme", action: {})
}
