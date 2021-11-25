//
//  FlashcardsView.swift
//  MusicalRooms
//
//  Created by Chelsea Ling on 19/11/21.
//

import SwiftUI

struct FlashcardsView: View {
    
    var words: [Word]
    var currentWord: Int
    
    @State var duplicateCurrentWord = 0
    @State var isFlipped = false
    @State var degrees: Angle = Angle(degrees: 0)
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 300, alignment: .center)
                    .foregroundColor(Color("lightBrown"))
                    .rotation3DEffect(degrees, axis: (x: 0, y: 1, z: 0))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            degrees += Angle(degrees: 180)
                            isFlipped.toggle()
                        }
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 50, alignment: .leading)
                    .foregroundColor(Color("darkBrown"))
                    .overlay(
                        Text("\(duplicateCurrentWord + 1) / \(words.count)")
                            .font(.system(size: 19, design: .rounded))
                            .foregroundColor(Color("evenLighterBrown"))
                            .bold()
                            .offset(x: -120)
                    )
                    .offset(y: -125)
                
                VStack {
                    if isFlipped {
                        Text(words[duplicateCurrentWord].definition)
                            .font(.system(size: 23, design: .rounded))
                            .frame(width: 250, height: 300, alignment: .center)
                            .rotation3DEffect(.degrees(180), axis: (x:0, y:1, z:0))
                    } else {
                        Text(words[duplicateCurrentWord].title)
                            .bold()
                            .font(.system(size: 30, design: .rounded))
                        if let altText = words[duplicateCurrentWord].altText {
                            Text(altText)
                                .font(.system(size: 20, design: .rounded))
                        } else {
                            Text("  ")
                                .font(.system(size: 20, design: .rounded))
                        }
                    }
                }
                .offset(y: 15)
                .rotation3DEffect(degrees, axis: (x: 0, y: 1, z: 0))
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 350, height: 70)
                .foregroundColor(Color("lightBrown"))
                .overlay(
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)){
                                if duplicateCurrentWord != 0 {
                                    duplicateCurrentWord -= 1
                                } else if duplicateCurrentWord == 0 {
                                    duplicateCurrentWord = words.count - 1
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.left.2")
                                .foregroundColor(Color("darkerBrown"))
                                .font(.system(size: 35))
                        }
                        .offset(x: -50)
                        
                        Rectangle()
                            .frame(width: 2)
                            .foregroundColor(Color("darkBrown"))
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)){
                                if isFlipped {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    if duplicateCurrentWord + 1 != words.count {
                                        duplicateCurrentWord += 1
                                    } else if duplicateCurrentWord == words.count - 1 {
                                        duplicateCurrentWord = 0
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: isFlipped ? "checkmark" : "chevron.right.2")
                                .foregroundColor(Color("darkerBrown"))
                                .font(.system(size: 35))
                        }
                        .offset(x: 50)
                    }
                )
                .offset(y: 30)
        }
        .onAppear {
            duplicateCurrentWord = currentWord
        }
        .offset(y: -100)
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView(words: [Word(title: "AAA", definition: "AAA")], currentWord: 0)
    }
}