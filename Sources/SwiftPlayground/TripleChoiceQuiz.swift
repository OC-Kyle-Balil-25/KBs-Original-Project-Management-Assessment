import SwiftTUI

struct ContentView: View {
@State private var points: Int = 0
@State private var answerText: String = "Points: 0"
@State public var questionConst: String = "Question:"
@State public var randomAnswers: String = "Answer #"
@State public var threeScroller: String = 0

    var body: some View {
        VStack(alignment: .center, spacing: 1) {
Text("--- \(questionConst) ---")
HStack(spacing: 2) {
    Button("randomAnswers[0])") {
        points += 1
        answerText = "Correct answer! You now have \(points) points!"
    }
    
    Button("randomAnswers[1])") {
        answerText = "Wrong answer! You still have \(points) points!"
    }
    
    Button("randomAnswers[2])") {
        answerText = "Wrong answer! You still have \(points) points!"
    }
    for randomAnswer in randomAnswers {
        Button(randomAnswers[threeScroller]) {
        points += 1
        answerText = "Correct answer! You now have \(points) points!"
        }
    }
}

Text("--- \(answerText) ---")
        }
.padding()
.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}