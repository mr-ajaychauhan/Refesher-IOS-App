//
//  OnboardingView.swift
//  Restart-App
//
//  Created by Drillmaps India on 07/10/22.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = true
    @State private var buttonWidth : Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating:Bool = false
    @State private var imageOffset:CGSize = .zero
    @State private var inducatorOpecity :Double = 1.0
    @State private var TextTitle : String = "Share."
    let haptickFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack  {
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
            VStack(spacing:20){
                //MARK: - HEADER
                
                Spacer()
                VStack(spacing: 0){
                    Text(TextTitle)
                        .font(.system(size:60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(TextTitle)
                    Text("""
                            Successfully made first ios app with by AJAY CHAUHAN
                            """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                }// VSTACK - HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y:isAnimating ? 1 : -40)
                .animation(.easeInOut(duration: 1), value: isAnimating)
                
                //MARK: - CENTER
                
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        .offset(x:imageOffset.width * 1.2,y:0)
                        .rotationEffect(.degrees(   Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{gesture in
                                    if abs(imageOffset.width) <= 150{
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            inducatorOpecity = 0
                                            TextTitle  = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        inducatorOpecity = 1
                                        TextTitle = "Share."
                                    }
                                }
                        )//GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//ZSTACK ----> CENTER
                .overlay(
                    Image(systemName:"arrow.left.and.right.circle")
                        .font(.system(size:44,weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(inducatorOpecity)
                    ,alignment: .bottom
                )
                
                Spacer()
                //MARK: - FOOTER
                
                ZStack{
                    //......1.BACKGROUND STATIC
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    //2......CALL TO ACTION STATIC
                    
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    //3.....CAPSULE DYNAMIC WIDTH
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    //4......CRICLE DRAGABLE
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName:"chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80,alignment: .center)
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ getrure in
                                    if getrure.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = getrure.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)){
                                        if buttonOffset > buttonWidth / 2 {
                                            haptickFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }else{
                                            haptickFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )//: GESTURE
                        Spacer()
                    } //: HSTACK
                } //: VSTACK FOOTER
                .frame(width:buttonWidth,height:80,alignment:.center )
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y:isAnimating ? 1 : -40)
                .animation(.easeInOut(duration: 1), value: isAnimating)
            } //:VSTACK
        } //:ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

//MARK: - PREVIEW

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
