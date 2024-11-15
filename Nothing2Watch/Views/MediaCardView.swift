//
//  MediaCardView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 7/2/23.
//

import SwiftUI

struct MediaCardView: View {
    @EnvironmentObject var viewModel: HomeSwipeViewModel
    @State var media: media

    @Binding var showingIndividualMediaView: Bool
    @Binding var iconsAreShowing: Bool
    
    // Gesture properties
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    

    var body: some View {
        
        
        GeometryReader{ proxy in
            let size = proxy.size
            let index = CGFloat(viewModel.getIndex(media: media))
            
            // show next 2 cards at top of stack...
            let topOffset = (index <= 2 ? index : 2) * 10
            
            ZStack(alignment: .leading){
                
                
                Image(media.imageName)
                    .resizable()
                    //reduce width
                    .frame(width: 400 - (topOffset), height: 650)
                    .cornerRadius(25)
                
            
                
                //Title/genre stuff
                
                
                VStack {
                    Spacer()

                    VStack(alignment: .leading) {
                       
                        Button {
                            showingIndividualMediaView.toggle()
                        }label: {
                            
                            //MOVIE INFO
                            VStack(alignment: .leading) {
                                Text(media.name).font(.largeTitle).fontWeight(.bold)
                                Text(media.genre).font(.title)
                            }
                        }

                    }.padding(.bottom, 40)



                }.padding().foregroundColor(.white)
                    
                
                
            }
            .offset(y: -topOffset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            
        }.offset(x: offset)
            .rotationEffect(.init(degrees: getRotationAngle(angle: 6)))
            .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
            .gesture(iconsAreShowing == false ?
                
                DragGesture()
                
                    .updating($isDragging, body: { value, out, _ in
                out = true
            })
                    .onChanged({ value in
                        
                        let translation = value.translation.width
                        offset = (isDragging ? translation : .zero)
                        
                    })
                    .onEnded({ value in
                        
                        let width = getRect().width - 50
                        let translation = value.translation.width
                        
                        let checkingStatus = (translation > 0 ? translation : -translation)
                        
                        
                        withAnimation {
                            if (checkingStatus > (width / 2)) {
                                //remove card
                               
                                offset = (translation > 0 ? width : -width) * 2
                                endSwipeActions()
                                if translation > 0 {
                                    rightSwipe()
                                }
                                else {
                                    leftSwipe()
                                }
                            }
                            else {
                                //reset card
                                offset = .zero
                            }
                        }
                       
                        
                    } )
                     : nil)//end of gesture
            //receive notification of swipe (via button)
            .onReceive(NotificationCenter.default.publisher(for:
               Notification.Name("ACTIONFROMBUTTON"), object: nil)) {
                data in
                
                guard let info = data.userInfo else {
                    return
                }
                
                let id = info["id"] as? String ?? ""
                let rightSwipe = info["rightSwipe"] as? Bool ?? false
                let width = getRect().width - 50
                
                if media.id == id {
                    
                    //removing card

                    withAnimation{
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe()
                    }
                    else {
                        self.leftSwipe()
                    }
                }
                    
                }
            }
        
        
        
                }//body
    
    
    //Rotate card based on swipe
    func getRotationAngle(angle: Double) -> Double {
        
        let rotation = (offset / (getRect().width - 50)) * angle
        
        return rotation
        
    }
    
    
    //Remove the media card from the arry once it is moved off screen
    func endSwipeActions() {
        
        withAnimation(.none){endSwipe = true}
        
        
        //Delayed based on animation duration
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = viewModel.displaying_media?.first{
                
                let _ = withAnimation{
                    viewModel.displaying_media?.removeFirst()
                }
            }
        }
        
    }
    
    func leftSwipe() {
        //NOTIFY ALGORITHM NOT TO SHOW THIS MEDIA/RELATED MEDIA
        print("Swiped left")
    }
    
    func rightSwipe() {
        //ADD TO LIKED
        print("Swiped right")
    }
    
            }//struct
        
        
        
        
        
        
        //Recognize which media is currently being displayed
//        let index = CGFloat(viewModel.getIndex(media: media))
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
//        }
            
            
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
        


struct MediaCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwipeView()
    }
}
