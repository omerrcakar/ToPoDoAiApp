//
//  ToDoListView.swift
//  todoFirebaseApp
//
//  Created by ÖMER  on 17.05.2024.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    
    @StateObject var viewModel: ToDoListeViewViewModel
    @FirestoreQuery var items : [ToDoListItem]
    
    
    
    init(userID:String){
        self._items = FirestoreQuery(collectionPath: "users/\(userID)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListeViewViewModel(userId: userID))
    }
    
    var body: some View {
        
        NavigationStack{
            VStack{
                
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions{
                            Button("Sil"){
                                viewModel.delete(id: item.id)
                            }.background(.red)
                        }
                }.listStyle(PlainListStyle())
                
            }.navigationTitle("Görevler")
                .toolbar{
                    Button{
                        // sheet açılır
                        viewModel.showingNewItemView = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }.sheet(isPresented: $viewModel.showingNewItemView, content: {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                })
        }
        
    }
}

#Preview {
    ToDoListView(userID: "deneme")
}
