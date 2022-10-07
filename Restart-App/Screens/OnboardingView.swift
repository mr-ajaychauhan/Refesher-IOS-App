//
//  OnboardingView.swift
//  Restart-App
//
//  Created by Drillmaps India on 07/10/22.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = true
    var body: some View {
        ZStack  {
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
            VStack(spacing:20){
                //HEADER
                
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
                } //:VSTACK ---> :HEADER
                
                //CENTER
                
                ZStack{
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2),lineWidth: 40)
                            .frame(width: 260,height: 260,alignment: .center)
                        Circle()
                            .stroke(.white.opacity(0.2),lineWidth: 80)
                            .frame(width: 260,height: 260,alignment: .center)
                    }
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }//:ZSTACK ----> :CENTER
                
                Spacer()
                //FOOTER
                
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
                            .frame(width: 80)
                        
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
                        .onTapGesture {
                            isOnboardingViewActive = false
                        }
                        Spacer()
                    }
                    
                }
                .frame(height:80,alignment:.center )
                .padding()
                
                
                
                
            } //:VSTACK
        } //:ZSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
