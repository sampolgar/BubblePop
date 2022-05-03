//
//  ViewModel.swift
//  BubblePopFinal
//
//  Created by Samuel Polgar on 3/5/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Score]()
    
    func getPlayer() {
        
        let db = Firestore.firestore()
        
        db.collection("players").getDocuments { snapshot, error in
            if error == nil {
                
            } else {
                if let snapshot = snapshot {
                    
                    snapshot.documents.map { doc in
                        
                        return Player(id: doc.documentID,
                                      name: doc["score"] as? String ?? "")
                        
                        
                    }
                    //get all the documents and create scores
                } else {
                    //handle error
                }
                
            }
            
        }
        
        
    }
     
    
}
