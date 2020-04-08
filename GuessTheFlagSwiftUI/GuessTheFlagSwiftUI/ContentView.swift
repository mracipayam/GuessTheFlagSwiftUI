//
//  ContentView.swift
//  GuessTheFlagSwiftUI
//
//  Created by Murat Han on 6.04.2020.
//  Copyright © 2020 mracipayam. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var message = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.yellow,.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing : 30){
                VStack{
                    Text("Which one is")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Text(countries[correctAnswer] + " ? ")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action:{
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black , lineWidth: 1))
                            .shadow(color : .black, radius: 2)
                    }
                }
                Section{
                    Text("Score is : \(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.ultraLight)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
        }
    }
    //-----------------Functions-------------------------
    func flagTapped ( _ number : Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            message = "You choose the right flag!"
        } else {
            let clicked = countries[number]
            scoreTitle = "Wrong"
            message = "You choose \(clicked)!"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
