import SwiftTUI

struct ContentView: View {
// 1. State Variables
// When these change, SwiftTUI automatically redraws the screen!
// @State private var name: String = ""
// @State private var greetingMessage: String = ""
// @State private var counter: Int = 0
@State private var points: Int = 0
@State private var answerText: String = "Points: 0"

    var body: some View {
        VStack(alignment: .center, spacing: 1) {
// Text("--- Interactive SwiftTUI Demo ---")

// // --- SECTION 1: Text Field (Input) ---
// Text("Enter your name:")

// // TextField replaces `readLine()`.
// // The `$name` binding means whatever the user types goes straight into `self.name`.
// TextField("Type here...", text: $name)
//     .frame(width: 30)

// // --- SECTION 2: Buttons ---
// HStack(spacing: 2) {
//     Button("Submit") {
//         if !name.isEmpty {
//             greetingMessage = "Hello, \(name)!"
//         } else {
//             greetingMessage = "Please type a name first!"
//         }
//     }
    
//     Button("Clear") {
//         name = ""
//         greetingMessage = ""
//     }
// }

// // Display greeting if present
// if !greetingMessage.isEmpty {
//     Text(greetingMessage)
// }

// Text("--------------------------------")

// // --- SECTION 3: Counter Example ---
// Text("Counter Value: \(counter)")

// HStack(spacing: 2) {
//     Button("- Decrement") {
//         counter -= 1
//     }
    
//     Button("+ Increment") {
//         counter += 1
//     }
// }

// --- SECTION 4: 4-Option Button Quiz ---
Text("--- eightScroller). questionVar) ---")
HStack(spacing: 2) {
    Button("randomAnswers[0])") {
        points += 1
        answerText = "Correct answer! You now have \(points) points!"
        Text("Correct answer! You now have \(points) points!")
    }
    
    Button("randomAnswers[1])") {
        answerText = "Wrong answer! You still have \(points) points!"
    }
    
    Button("randomAnswers[2])") {
        answerText = "Wrong answer! You still have \(points) points!"
    }
}

Text("--- \(answerText) ---")
        }
.padding()
.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}