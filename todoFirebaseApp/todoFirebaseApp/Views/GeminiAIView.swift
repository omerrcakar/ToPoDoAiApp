//
//  GeminiAIView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 20.05.2024.
//

import SwiftUI
import GoogleGenerativeAI

struct GeminiAIView: View {
    
    // modelimizi oluşturuyoruz
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var userPrompt = ""
    @State var response :LocalizedStringKey = "How can I help you today?"
    @State var isLoading = false
    
    var body: some View {
        
        VStack{
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top, 40)
            
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint:.indigo))
                        .scaleEffect(4)
                }
            }
            
            TextField("Ask anything",text: $userPrompt,axis: .vertical)
                .lineLimit(5)
                .font(.title)
                .padding()
                .background(Color.indigo.opacity(0.2),in:Capsule())
                .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.12)
                .autocorrectionDisabled(true)
                .onSubmit {
                    generateResponse()
                }
        }
        
    }
    
    func generateResponse(){
        isLoading = true
        response = ""
        // Bu, Swift'in concurrency modelinde kullanılan bir yapı taşıdır. Task bir iş parçacığında (thread) çalıştırılan bir görev oluşturur ve async/await ile çalışır.
        // await : Asenkron bir fonksiyonun sonucunu beklemek için kullanılır.
        // Task Swift concurrency modelinde asenkron görevler oluşturmak için kullanılan bir yapıdır. Bir Task oluşturduğunuzda, bu görev asenkron olarak çalışır ve await anahtar kelimesi ile diğer asenkron fonksiyonları çağırabilirsiniz. Task'ın amacı, iş parçacıklarının yönetimini geliştiricinin omuzlarından alarak asenkron kod yazmayı daha kolay ve güvenli hale getirmektir.
        Task{
            do{
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found")
                userPrompt = ""
            }catch {
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    GeminiAIView()
}
