//
//  User.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import Foundation

// API'den alınan JSON verisini User yapısına dönüştürebilir veya bir User nesnesini JSON formatında gönderebilirsiniz.

struct User:Codable{
    let id:String
    let name:String
    let email:String
    let joined:TimeInterval
}
