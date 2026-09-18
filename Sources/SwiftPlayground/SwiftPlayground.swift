import Foundation
import SwiftTUI

@main
struct SwiftPlayground: App {
    var body: some Scene {
        WindowGroup {
            TripleChoiceQuiz()
        }
    }
}

struct TripleChoiceQuiz: View {

/* Points System */
/// Total Sum/Product of Points Accumulated/Decumulated.
@State private var pointTotal: Double = 0
/// Displays and Confirms Answer validity including total number of Points having been affected by button responses, in TERMINAL.
@State private var pointDisplay: String = "Points: 0"

/* Quiz Progress State */
/// Index Number of Current Question & indirectly, Correct Answer.
@State private var currentListIndex: Int = 0
/// Shuffled List of 8 Indexes to Shuffle Order of Connected Questions and Correct Answers.
@State private var randomIndexOrder: [Int] = Array(0..<8).shuffled()

/* Multiplier State */
/// Index Number of Current Question & indirectly, Correct Answer.
@State private var pointMultiplier: Double = 1

/* Current Display State */
/// Displays Current Question in TERMINAL.
@State private var currentQuestionDisplay: String = "Loading Coordinationally Geometric Knowledge..."
/// List of Three Shuffled Answers.
@State private var currentAnswerList: [String] = []
/// Correct Answer Respective to currentQuestionDisplay.
@State private var correctAnswer: String = ""

/* 0-4: Formulae | 5-7: Triangular Centre */
/// Fixed list of questions.
// let questionList = [
//     "1", "2", "3", "4", "5", "6", "7", "8"
// ]
let questionList = [
    "What is the formula for finding the distance between two points?",
    "What is the formula for finding the gradient between two points?",
    "What is the formula for finding the midpoint between two points?",
    "What is the equation of a linear line?",
    "How do you find the negative reciprocal of a gradient?",
    "What is the Centroid?",
    "What is the Circumcentre?",
    "What is the Orthocentre?"
]
/// Fixed list of answers.
// let answerList = [
//     "1", "2", "3", "4", "5", "6", "7", "8"
// ]
let answerList = [
    "(x2-x1, y2-y1)",
    "(y2-y1)/(x2-x1)",
    "(x1+x2, y1+y2)/2",
    "y=mx+c",
    "(a/b -> -a/b or a/-b)",
    "Tri-intersection point of a triangle based on lines from midpoints to directly opposite vertices",
    "Tri-intersection point of a triangle based on lines from perpendicular bisector midpoints",
    "Tri-intersection point of a triangle based on lines from perpendicular bisectors to directly opposite vertices"
]

/// Terminal Display
var body: some View {
    VStack(alignment: .center, spacing: 1) {
        Text("--- \(currentQuestionDisplay) ---")
        // Three Buttons containing one Answer each.
        if currentAnswerList.count == 3 {
            HStack(spacing: 2) {
                Button(currentAnswerList[0]) {
                    pickAnswer(containing: currentAnswerList[0])
                }
                Button(currentAnswerList[1]) {
                    pickAnswer(containing: currentAnswerList[1])
                }
                Button(currentAnswerList[2]) {
                    pickAnswer(containing: currentAnswerList[2])
                }
            }
        }
        Text("--- \(pointDisplay) ---")
        
        Button("\(pointMultiplier)x") {
            multiplyPoints()
        }
    }
    // Repositions Button Contents further away from Button Edges.
    .padding()
    // Expands Borders to Centrally Encompass Full TERMINAL.
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    /// Displays first Question on Startup.
    .onAppear {
        nextQuestion()
    }
}

/*
: Checks Answer Validity when Respective Button Picked.
: - Parametres:
:   - currentAnswerSingle: Each Individual Answer from [currentAnswerList]
*/
func pickAnswer(containing currentAnswerSingle: String) {
    if currentAnswerSingle == correctAnswer {
        // Correct Answer adds a point.
        pointTotal += 1
        // Confirms Correctness of Answer with changed Point Total
        pointDisplay = "Correct answer! You now have \(pointTotal) points!"
    } else {
        // Confirms Wrongness of Answer with unchanged Point Total
        pointDisplay = "Wrong answer! You still have \(pointTotal) points!"
    }
    currentListIndex += 1
    nextQuestion()
}

/*
: Multiplies pointTotal by a random amount. Both decreasing and increasing multipliers.
*/
func multiplyPoints() {
    pointMultiplier = Array(stride(from: 0.25, through: 3, by: 0.25)).randomElement()!
    pointTotal *= pointMultiplier
}

/*
: Sets up Next Question, or displays Summary if Quiz has ended.
*/
func nextQuestion() {
    // Checks if all Questions have been Answered.
    if currentListIndex >= randomIndexOrder.count {
        // Confirms and Displays Quiz Completion.
        currentQuestionDisplay = "All questions answered!"
        // Displays Final Score.
        pointDisplay = "Your final score sums to \(pointTotal)/\(randomIndexOrder.count) points!"
    } else {
        /// Picks shuffled index from [randomIndexOrder], according to current knowledgeable content progression of quiz.
        var randomListIndex = randomIndexOrder[currentListIndex]
        // Picks Next Question using randomListIndex, for Next Question Display.
        currentQuestionDisplay = questionList[randomListIndex]
        // Sets up Correct Answer Connected to Next Question.
        correctAnswer = answerList[randomListIndex]

        /// Container for Three Answers before Shuffling.
        var possibleAnswerList: [String] = ["Incorrect","Answers"]

        if randomListIndex >= 5 && randomListIndex <= 7  {
            /* Answer Category: Triangular Centre */
            // Instant 3 Answers with only 1 always Correct and no Duplicates.
            possibleAnswerList = Array(answerList[5...7])
        } else {
            /* Answer Category: Formulae */
            // Container for more than Three Answers (Formulae Answer Category), to be cut down.
            var otherAnswerList = Array(answerList[0...4])
            // Removes Correct Answer Connected to Next Question.
            otherAnswerList.removeAll {
                $0 == correctAnswer
            }
            // Shuffles List of all Incorrect (Formulae) Answers.
            otherAnswerList.shuffle()

            /// Used to scroll through 2-Element Arrays.
            var twoScroller = 0

            /// Sets up 3-Answer (Formulae) List for Next Question.
            for possibleAnswerSingle in possibleAnswerList {
                // Adds 2 Incorrect Answers First
                possibleAnswerList[twoScroller] = otherAnswerList[twoScroller]
                // Prepares Loop to Collect Second Incorrect Answer.
                twoScroller += 1
            }
            // Adds 1 Correct Answer Last.
            possibleAnswerList.append(correctAnswer)
        }
        // Shuffles Complete Answer List for Maximum Non-Cheesability, for Next Question.
        currentAnswerList = possibleAnswerList.shuffled()
    }
}
    
}