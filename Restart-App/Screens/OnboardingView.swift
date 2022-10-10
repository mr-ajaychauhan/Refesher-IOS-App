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
    
    var body: some View {
        ZStack  {
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
            VStack(spacing:20){
                //MARK: - HEADER
                
                Spacer()
                VStack(spacing: 0){
                    Text("Share")
                        .font(.system(size:60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
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
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                }//ZSTACK ----> CENTER
                
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
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }else{
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
    }
}

//MARK: - PREVIEW

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
