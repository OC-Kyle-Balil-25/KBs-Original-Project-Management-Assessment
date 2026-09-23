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

/* Plural Variables */
/// Single Letter to accurately follow single-letter pluralism when needed in TERMINAL.
@State private var pluralS: String = ""
/// "Be" Past-Tense to accurately follow "Be" Past-Tense pluralism when needed in TERMINAL.
@State private var pluralWasWere: String = "was"
/// Temporary debugging plural to display in TERMINAL.
@State private var testPlural: String = ""
/// Private copy of pluralS specifically for "multiplier/multipliers".
var multiplierPlural = ""

/* Points System */
/// Total Sum/Product of Points Accumulated/Decumulated.
@State private var pointTotal: Double = 0
/// Displays and Confirms Answer validity including total number of Points having been affected by button responses, in TERMINAL. Starts specifically as "Points: 0" because no Questions or Multipliers have been Answered/Used yet.
@State private var pointDisplay: String = "Points: 0"
/// Total Number of Questions Answered Correctly.
@State private var correctTotal: Double = 0

/* Quiz Progress State */
/// Index Number of Current Question & indirectly, Correct Answer.
@State private var currentListIndex: Int = 0
/// Shuffled List of 8 Indexes to Shuffle Order of Connected Questions and Correct Answers.
@State private var randomIndexOrder: [Int] = Array(0..<8).shuffled()

/* Multiplier State */
// Randomized multiplier to affect pointTotal. Starts displayed as 1 to show that pointTotal has not yet been significantly affected in TERMINAL.
@State private var pointMultiplier: Double = 1
// Ensures multiplyPoints() can only be used once per Question on average.
@State private var multiplierAttempts: Double = 0
/// Actively displays total amount of Multipliers in TERMINAL.
@State private var multiplierDisplay: String = "You have 0 Multipliers! Answer more questions to earn more Multipliers!"

/* Current Display State */
/// Displays Current Question in TERMINAL.
@State private var currentQuestionDisplay: String = "Loading Coordinationally Geometric Knowledge..."
/// List of Three Shuffled Answers.
@State private var currentAnswerList: [String] = []
/// Correct Answer Respective to currentQuestionDisplay.
@State private var correctAnswer: String = ""

/* 0-4: Formulae | 5-7: Triangular Centre */
/// Fixed list of questions.
let questionList = [
    "1", "2", "3", "4", "5", "6", "7", "8"
]
// let questionList = [
//     "What is the formula for finding the distance between two points?",
//     "What is the formula for finding the gradient between two points?",
//     "What is the formula for finding the midpoint between two points?",
//     "What is the equation of a linear line?",
//     "How do you find the negative reciprocal of a gradient?",
//     "What is the Centroid?",
//     "What is the Circumcentre?",
//     "What is the Orthocentre?"
// ]
// / Fixed list of answers.
let answerList = [
    "1", "2", "3", "4", "5", "6", "7", "8"
]
// let answerList = [
//     "(x2-x1, y2-y1)",
//     "(y2-y1)/(x2-x1)",
//     "(x1+x2, y1+y2)/2",
//     "y=mx+c",
//     "(a/b -> -a/b or a/-b)",
//     "Tri-intersection point of a triangle based on lines from midpoints to directly opposite vertices",
//     "Tri-intersection point of a triangle based on lines from perpendicular bisector midpoints",
//     "Tri-intersection point of a triangle based on lines from perpendicular bisectors to directly opposite vertices"
// ]

/// TERMINAL Display.
var body: some View {
    VStack(alignment: .center, spacing: 1) {
        // Displays Quiz Progress.
        Text("--- \(currentQuestionDisplay) ---")
        // Three Buttons containing one Answer each.
        if currentAnswerList.count == 3 {
            HStack(spacing: 2) {
                for currentAnswer in currentAnswerList {
                    Button(currentAnswer) {
                        pickAnswer(containing: currentAnswer)
                    }
                }
            }
        }
        // Displays Actively Changing Total of Points with Reason.
        Text("--- \(pointDisplay) ---")
        
        // Manages Multiplier Bonus.
        Button("\(pointMultiplier)x") {
            multiplyPoints()
        }
        
        // Displays attempts left to use the Random Multiplier.
        Text("--- \(multiplierDisplay) ---")
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
        correctTotal += 1
        // Confirms Correctness of Answer with changed Point Total.
        updatePoints(suffixing: "Correct answer! You now")
    } else {
        // Confirms Wrongness of Answer with unchanged Point Total.
        updatePoints(suffixing: "Wrong answer! you still")
    }
    currentListIndex += 1
    nextQuestion()
}

/*
: Multiplies Points by a random amount. Both decreasing and increasing Multipliers.
*/
func multiplyPoints() {
    if multiplierAttempts != 0 {
        // Randomizes multiplier from a range of 0.25-3.00, in increments of 0.25.
        pointMultiplier = Array(stride(from: 0.25, through: 3, by: 0.25)).randomElement()!
        // Multiplies current pointTotal.
        pointTotal *= pointMultiplier
        // Updates Point Display to reflect Multiplier change.
        updatePoints(suffixing: "You now")
        multiplierAttempts -= 1
    }
    // Adapts multiplierDisplay based on Subtraction of a Multiplier.
    updateMultipliers()
}

/*
: Updates Points with a Reason Statement.
: - Parametres:
:   - reasonStatement: Reason prefixing how pointTotal was actively changed.
*/
func updatePoints(suffixing reasonStatement: String) {
    // Checks if pointTotal is numerically either singular or plural after Effect contextualized by reasonStatement.
    adaptPlural(using: pointTotal)
    /// Privately copies pluralS specifically to adapt "point/points".
    var pointPlural = pluralS
    // Confirms reason of changed pointTotal all displayed in TERMINAL.
    pointDisplay = "\(reasonStatement) have \(pointTotal) point\(pointPlural)!"
}

/*
: Updates Multiplier Attempt Total.
*/
func updateMultipliers() {
    /// Adapts pluralS based on Addition/Subtraction of a Multiplier.
    adaptPlural(using: multiplierAttempts)
    /// Privately copies pluralS specifically to adapt "multiplier/multipliers" after Addition/Subtraction of a Multiplier.
    var multiplierPlural = pluralS
    // Updates multiplierDisplay to reflect Multiplier Subtraction.
    multiplierDisplay = "You have \(multiplierAttempts) Multiplier\(multiplierPlural)! Answer more questions to earn more Multipliers!"
}

/*
: Sets up Next Question, or displays Summary if Quiz has ended.
*/
func nextQuestion() {
    // Checks if all Questions have been Answered.
    if currentListIndex >= randomIndexOrder.count {
        // Confirms and Displays Quiz Completion. Fixed number of Total Questions = adaptPlural() unneeded.
        currentQuestionDisplay = "[\(currentListIndex)/\(randomIndexOrder.count)] All questions answered!"
        // Displays Final Score. Fixed number of Total Questions = adaptPlural() unneeded for “point/->points<-”, "question/->questions<-", and “was/->were<-”.
        pointDisplay = "Your final score sums to \(pointTotal)/\(randomIndexOrder.count) points! \(correctTotal)/\(randomIndexOrder.count) questions were answered correctly!"
    } else {
        /// Picks shuffled index from [randomIndexOrder], according to current knowledgeable content progression of quiz.
        var randomListIndex = randomIndexOrder[currentListIndex]
        // Picks Next Question using randomListIndex, for Next Question Display.
        currentQuestionDisplay = "[\(currentListIndex)/\(randomIndexOrder.count)] \(questionList[randomListIndex])"
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

        // Adds one Multiplier per Question Answered.
        multiplierAttempts += 1

        // Adapts multiplierDisplay based on Subtraction of a Multiplier.
        updateMultipliers()
    }
}

/*
: Checks a number's pluralism to convert the affected subject word to plural or singular when needed.
: - Parametres:
:   - numericUnit: Number being tested for pluralism.
:   - usedPlural: Plural Fix used as a result of numericUnit and specific word affected.
*/
func adaptPlural(using numericUnit: Double) {
    // Tests selected number for pluralism.
    if numericUnit == 1 {
        // Words should grammatically be singular.
        pluralS = ""
        pluralWasWere = "was"
    } else {
        // Words should grammatically be plural.
        pluralS = "s"
        pluralWasWere = "were"
    }
}

}