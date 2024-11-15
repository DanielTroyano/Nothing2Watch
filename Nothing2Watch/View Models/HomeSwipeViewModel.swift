//
//  HomeSwipeViewModel.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/10/23.
//

import FirebaseAuth
import FirebaseFirestore

class HomeSwipeViewModel: ObservableObject {
    @Published var fetched_media: [media] = []
    
    @Published var displaying_media: [media]?
    
    init() {
        
        
        
        // fetching media...
        fetched_media =     [
            media(name: "Green Knight", imageName: "GreenKnight", description: "I have no idea", genre: "Action", destination: PlaceHolderView()),
            media(name: "Moonlight", imageName: "Moonlight", description: "Deep asf", genre: "Action", destination: PlaceHolderView()),
            media(name: "Batman", imageName: "Batman", description: "Not a bat movie", genre: "Action", destination: PlaceHolderView()),
            media(name: "SCARFACE", imageName: "Scarface", description: "Say ello to my liddle fren", genre: "Action", destination: PlaceHolderView()),
            media(name: "The Godfather", imageName: "Godfather", description: "Sonny's a hothead", genre: "Action", destination: PlaceHolderView())
            
           
        ]
        
        // storing it in displaying media(will update based on user interaction)
        displaying_media = fetched_media
        
        
    }
    
        // retreiving media index...
    func getIndex(media: media) -> Int {
        
        let index = displaying_media?.firstIndex(where: { currentMedia in
            return media.id == currentMedia.id
        }) ?? 0
        
        return index
        
    }
    
   
    
    
    //Misc stuff
    
    

    //beginning of getting google/twitter sign's info (or access through mediary platform :/)
    func assignName(name: String) {
        
    }
    
    

    @Published var iconsAreShowingCrossOver = false
    
    func toggleIconsAreShowingCrossOver() {
        iconsAreShowingCrossOver.toggle()
    }
    
}

