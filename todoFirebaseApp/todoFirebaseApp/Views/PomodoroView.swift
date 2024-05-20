//
//  PomodoroView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 20.05.2024.
//

import SwiftUI
import UserNotifications

struct PomodoroView: View {
    @State private var timer: Timer?
    @State private var timeRemaining = 0
    @State private var selectedDuration: Int? // Seçilen süreyi takip etmek için bir durum

    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]){ success,error in
            if success{
                print("Başarılı")
            }else{
                print("Başarısız")
            }
        }
    }

    var body: some View {
        VStack {
            Text("\(formattedTime)").font(.system(size: 55)).bold()
                .padding()
                .shadow(color: .black,radius: 2)
            
            HStack(spacing: 20) {
                Button(action: {
                    endTimer() // Yeni bir zamanlayıcı başlatmadan önce mevcut zamanlayıcıyı bitir
                    selectedDuration = 30 * 60 // 30 dakikalık zamanlayıcıyı başlat
                    startTimer(duration: selectedDuration!)
                }) {
                    Text("30 dk").font(.system(size: 14)).foregroundColor(.white).padding().background(.blue)
                        .cornerRadius(50).bold().shadow(color: .blue,radius: 15)
                }
                
                Button(action: {
                    endTimer() // Yeni bir zamanlayıcı başlatmadan önce mevcut zamanlayıcıyı bitir
                    selectedDuration = 5 * 2 // 5 dakikalık zamanlayıcıyı başlat
                    startTimer(duration: selectedDuration!)
                }) {
                    Text("5 dk").font(.system(size: 14)).foregroundColor(.white).padding().background(.blue)
                        .cornerRadius(50).bold().shadow(color: .blue,radius: 15)
                }
                
                if timer != nil {
                    Button(action: {
                        endTimer()
                    }) {
                        Text("Durdur").font(.system(size: 14)).foregroundColor(.white).padding().background(.blue)
                            .cornerRadius(50).bold().shadow(color: .blue,radius: 15)
                    }
                } else {
                    Button(action: {
                        resetTimer()
                    }) {
                        Text("Sıfırla").font(.system(size: 14)).foregroundColor(.white).padding().background(.blue)
                            .cornerRadius(50).bold().shadow(color: .blue,radius: 15)
                    }
                }
                
                if timer == nil {
                    Button(action: {
                        resumeTimer()
                    }) {
                        Text("Devam Et").font(.system(size: 14)).foregroundColor(.white).padding().background(.blue)
                            .cornerRadius(50).bold().shadow(color: .blue,radius: 15)
                    }
                }
            }
            .padding()
        }
    }
    
    func startTimer(duration: Int) {
        timeRemaining = duration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                endTimer()
                showNotification()
            }
        }
    }
    
    func resumeTimer() {
        if let duration = selectedDuration {
            startTimer(duration: timeRemaining)
        }
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        if let duration = selectedDuration {
            timeRemaining = duration
        }
        endTimer()
    }
    
    func showNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Tamamlandı!"
        content.body = "Zamanlayıcı süresi doldu."
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
