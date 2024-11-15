//
//  HomeSwipeView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/10/23.
//

import SwiftUI

struct HomeSwipeView: View {
    
    @EnvironmentObject var authentication: Authentication
    @StateObject var viewModel = HomeSwipeViewModel()
    
    @State var iconsAreShowing = false
    @State var showingIndividualMediaView = false
    
    //Get info from un-catalogued users (google/facebook)
    @State private var showingAlert = false
    @State private var newName = ""
   
    var body: some View {
        
        NavigationView {
            
            
            ZStack {
                
                //Background (CUSTOM GRADIENT LATER ON)
                    
                Image("BGWgradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

    
                //Icon menu behind main view in ZStack
                if iconsAreShowing {
                    SideMenuView(iconsAreShowing: $iconsAreShowing)
                }
                
                //Media stack
                ZStack {
                    HomeView(iconsAreShowing: $iconsAreShowing, showingIndividualMediaView: $showingIndividualMediaView)
                }
                    .cornerRadius(iconsAreShowing ? 20 : 10)
                    .offset(x: iconsAreShowing ? 300 : 0, y: iconsAreShowing ? 44 : 0)
                    .scaleEffect(iconsAreShowing ? 0.8 : 1)
                    .navigationBarItems(leading: Button(
                        action: {
                            
                            withAnimation(.spring()) {
                                iconsAreShowing.toggle()
                            }
                            
                            viewModel.toggleIconsAreShowingCrossOver()
                           
                            
                        },
                        
                        label: {
                            
                            ZStack {
                                
                                Circle()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                    .foregroundColor(.black)
                                
                                ZStack {
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35)
                                        .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769))
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                    
                                    
                                    Image("bars-solid")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 17)
                                    
                                    
                                    
                                }.offset(x:1, y:-4)
                                
                            }
                        }))
//                    .navigationTitle("Nothing2Watch")
//                    .navigationBarTitleDisplayMode(.inline )
                    .navigationViewStyle(StackNavigationViewStyle())
             .fullScreenCover(isPresented: $showingIndividualMediaView) {
                 PlaceHolderView()}
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
            
//        .onAppear() {
//            //check if user has spot in database, if not toggle showingAlert
//        }
//        .alert("Hello there! ", isPresented: $showingAlert) {
//                   TextField("", text: $newName)
//            Button("Enter") {
//                viewModel.assignName(name: newName)
//            }
//               } message: {
//                   Text("What's your name?")
//               }
    
        
    } .navigationBarBackButtonHidden(true)//body
    
}//struct




struct HomeSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwipeView()
   
    }
}








//Media and buttons view
    struct HomeView: View {
        @StateObject var viewModel = HomeSwipeViewModel()
        @Binding var iconsAreShowing: Bool
        @Binding var showingIndividualMediaView: Bool
        
        //let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
        
        var body: some View {
            
            ZStack {
                
                VStack {
                    
                    Spacer()
                    
                    
                    
                    //Media Stack
                    ZStack {
                        
                        
                        
                        if let medias = viewModel.displaying_media {
                            
                            if medias.isEmpty {
                                Text("Come back later for more reccomendations!")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                            
                            else {
                                
                                // Displaying cards...
                                ForEach(medias.reversed()) {media in
                                    
                                    // Card view...
                                    MediaCardView(media: media, showingIndividualMediaView: $showingIndividualMediaView, iconsAreShowing: $iconsAreShowing)
                                        .environmentObject(viewModel)
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                        
                        else {
                            ProgressView()
                        }
                        
                        //OG MEDIA STUFF
                        //                    ForEach(viewModel.displaying_media!) { Media in
                        //                        MediaView(media: Media)
                        //                    }
                        
                    }.zIndex(1.0)
                    //                    .padding(.top)
                    //End of ZStack
                    
                    
                    Spacer()
                    
                    //View shifting buttons
                    HStack {
                        
                        Spacer()
                        
                        
                        //Thumbs down button
                        Button {
                            
                            doSwipe(rightSwipe: false)
                            print("Swiped left")
                            
                        } label: {
                            ZStack {
                                
                                Circle()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 90)
                                    .foregroundColor(.black)
                                
                                ZStack {
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 83)
                                        .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769))
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                    
                                    
                                    Image("thumbdown")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50)
                                        .offset(y: 2)
                                    
                                    
                                    
                                }.offset(x:3, y:-5)
                                
                            }
                        }
                        
                        
                        
                        
                        Spacer()
                        
                        
                        
                        //Add to queue button
                        Button {
                            
                            print("added to queue")
                            
                        } label: {
                            ZStack {
                                
                                Circle()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                    .foregroundColor(.black)
                                
                                ZStack {
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40)
                                        .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769))
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                    
                                    
                                    Image("plus-solid")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                    
                                    
                                    
                                }.offset(x:2, y:-4)
                                
                            }
                        }.padding(.top, 45)
                        
                        
                        
                        Spacer()
                        
                        
                        //thumbs up button
                        Button {
                            
                            doSwipe(rightSwipe: true)
                            
                            print("Swiped right")
                        } label: {
                            ZStack {
                                
                                Circle()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 90)
                                    .foregroundColor(.black)
                                
                                ZStack {
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 83)
                                        .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769))
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                    
                                    
                                    Image("thumbup")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50)
                                    
                                    
                                    
                                    
                                }.offset(x:3, y:-5)
                                
                            }
                        }
                        
                        
                        Spacer()
                        
                    }.padding(.horizontal, 175)
                        .disabled(viewModel.displaying_media?.isEmpty ?? false)
                        .opacity((viewModel.displaying_media?.isEmpty ?? false) ? 0.6 : 1)
                        .disabled(iconsAreShowing == true ?? false)
                        .opacity((iconsAreShowing == true ?? false) ? 0.6 : 1)
                    //Triple button HStack
                    
                    Spacer()
                    
                    
                    
                    
                }
                
                
                
            }//main zstack
            
            
            
        }//body
        
        //removing cards when doing swipe
        func doSwipe(rightSwipe: Bool = false) {
            
            guard let first = viewModel.displaying_media?.first else {
                return
            }
            
            //using notifications to post & receive in stack cards...
            NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil,
                                            userInfo: [
                                                
                                                "id": first.id,
                                                "rightSwipe": rightSwipe
                                                
                                                
                                                
                                            ])
        }
    }
}//struct


















//struct MediaView: View {
//
//
//    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
//
//    @StateObject var viewModel = HomeSwipeViewModel()
//    @State var media: media
//
//
//    var body: some View {
//
//
//
//        ZStack(alignment: .leading){
//
//
//
//            Image(media.imageName)
//                .resizable()
//                .frame(width: 400, height: 650).cornerRadius(25)
//
//
//            //
//            //            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
//            //
//
//            VStack {
//                Spacer()
//
//                VStack(alignment: .leading) {
//                    //MOVIE INFO
//                    Text(media.name).font(.largeTitle).fontWeight(.bold)
//                    Text(media.genre).font(.title)
//
//
//                }.padding(.bottom, 40)
//
//
//
//            }.padding().foregroundColor(.white)
//
//
//
//
//
//        } //Step 1: ZStack recognizes coordinate values of card model
//        .offset(x: media.x, y: media.y)
//        .rotationEffect(.init(degrees: media.degree))
//
//        //Step 2: gesture recogniser updates coordinate values of the card model
//        .gesture (
//
//            DragGesture()
//
//            //User is dragging
//                .onChanged { value in
//                    withAnimation(.default) {
//                        media.x = value.translation.width
//                        media.y = value.translation.height
//                        media.degree = 7 * (value.translation.width > 0 ? 1 : -1)
//                    }
//                }
//
//            //On release (whether on or off screen)
//                .onEnded { value in
//                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
//                        switch value.translation.width {
//
//                            //reset to middle
//                        case 0...100:
//                            media.x = 0; media.degree = 0; media.y = 0
//
//                            //Swipe right (ASSIGN TO LIKED)
//                        case let x where x > 100:
//                            media.x = 1000; media.degree = 12
//
//                            //reset to middle
//                        case (-100)...(-1):
//                            media.x = 0; media.degree = 0; media.y = 0
//
//                            //Swipe left (ASSIGN TO DISLIKED)
//                        case let x where x < -100:
//                            media.x = -1000; media.degree = -12
//
//                        default: media.x = 0; media.y = 0
//                        }
//
//                    }
//                }
//
//        )//end of gesture
//
//
//
//
//
//    }//Body
//}//Struct
