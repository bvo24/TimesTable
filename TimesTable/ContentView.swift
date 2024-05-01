//
//  ContentView.swift
//  TimesTable
//
//  Created by Brian Vo on 5/1/24.
//

import SwiftUI

struct Question{
    let text : String
    let answer : Int
}


struct ContentView: View {
    
    
    
    
    
    @State private var inGame = false
    
    @State private var timesTable = 2
    
    @State private var difficulty : String = ""
    
    @State private var questionNumber = 0
    //let difficulties = ["Easy", "Medium", "Hard"]
    @State private var ans : Int = 0
    
    
    let numberOfQuestions = [5, 10, 20]
    @State private var numQuestionsIndex = 0
    @State private var questions : [Question] = []
    @State private var totalCorrect = 0
    
    
    var body: some View {
        if inGame{
            VStack(alignment: .leading){
                Section{
                    Text("What is \(questions[questionNumber].text)")
                    TextField("Enter your answer", value: $ans, format: .number)
                }.padding()
                Section{
                    Button("Next question!", action: nextQuestion)
                    Text("Correct \(totalCorrect)")
                }.padding()
                
                
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.headline)
//            .alignment(.center)
            
            
            
        }
        
        else{
            
            Form{
                Section("Pick your times table"){
                    Stepper("\(timesTable) times table", value: $timesTable, in: 2...12)
                }
            
                Section("Number of questions"){
                    Picker("How many", selection: $numQuestionsIndex){
                        ForEach(0..<3){  number in
                            Text("\(numberOfQuestions[number])")
                            
                        }
                            
                            
                    }
                    .pickerStyle(.segmented)
//                    Text("\(numQuestions)")
                    
                }
                Button("Start practice!" ,action: startGame)

            }
            
        }
    
        

        
    }
    
    func startGame(){
        inGame = true
        generateQuestions()
    }
    func generateQuestions(){
        questions.removeAll()
        for _ in 0...numberOfQuestions[numQuestionsIndex]{
            let num1 = Int.random(in: 0...12)
            let guess = "\(timesTable) * \(num1) ?"
            let answer = timesTable * num1
            let q = Question(text: guess, answer: answer)
            questions.append(q)
            
        }
        
        
        
        
    }
    func endGame(){
        ans = 0
        totalCorrect = 0
        numQuestionsIndex = 0
        questionNumber = 0
        inGame = false
    }
    
    func checkAnswer(){
        if(ans == questions[questionNumber].answer){
            totalCorrect += 1
        }
    
    }
    func nextQuestion(){
        checkAnswer()
        if questionNumber < numberOfQuestions[numQuestionsIndex] - 1{
            questionNumber += 1
            ans = 0
        }
        else{
            endGame()
        }
    }
    
    
    
    
    
}





#Preview {
    ContentView()
}
