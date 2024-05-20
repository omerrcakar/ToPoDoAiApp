//
//  APIKey.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 20.05.2024.
//

import Foundation
// guard let ifadesi, belirli bir koşulun sağlanıp sağlanmadığını kontrol eder ve sağlanmıyorsa belirli bir kod bloğunu çalıştırarak program akışını durdurur veya değiştirir.


enum APIKey {
    
  // Fetch the API key from `GenerativeAI-Info.plist`
  static var `default`: String {
      // GenerativeAI-Info.plist adlı dosyanın uygulama paketi içinde bulunup bulunmadığını kontrol eder.
      // Eğer dosya bulunamazsa, fatalError çağrılarak programın çalışması durdurulur ve hata mesajı verilir.
    guard let filePath = Bundle.main.path(forResource: "GenerativeAi-Info", ofType: "plist")
    else {
      fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
    }
      
    // Bulunan plist dosyasını bir NSDictionary nesnesine yükler.
      //Bu, plist dosyasının içeriğini anahtar-değer çiftleri olarak okumamıza olanak tanır.
    let plist = NSDictionary(contentsOfFile: filePath)
      
      // Bu satır, plist dosyasından API_KEY anahtarına karşılık gelen değeri alır.
      //Eğer bu anahtar bulunamaz veya değer bir String değilse, fatalError çağrılarak programın çalışması durdurulur ve hata mesajı verilir.
    guard let value = plist?.object(forKey: "API_KEY") as? String
      else {
      fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
    }
      // Bu satır, alınan API anahtarının geçerli olup olmadığını kontrol eder.
      //Eğer anahtar _ karakteri ile başlıyorsa, bu geçersiz bir anahtar anlamına gelir ve kullanıcıya bir hata mesajı ile API anahtarını nasıl alacağına dair bir bağlantı gösterilir.
    if value.starts(with: "_") {
      fatalError(
        "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
      )
    }
      // Eğer tüm kontroller başarılı olursa, plist dosyasından alınan ve geçerli olduğu doğrulanan API anahtarı döndürülür.
    return value
  }
    
}
