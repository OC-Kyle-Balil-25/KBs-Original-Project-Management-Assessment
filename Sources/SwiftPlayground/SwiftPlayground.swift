/// Imports Default Swift Code.
import Foundation
/// Imports Swift TERMINAL User Interface Code.
import SwiftTUI

/// Mains Code.
@main
/// Constructs Default Swift Code.
struct SwiftPlayground: App {
    /// Constructs TERMINAL.
    var body: some Scene {
        WindowGroup {
            // Calls TERMINAL Content.
            TripleChoiceQuiz()
        }
    }
}

/// TERMINAL Content.
struct TripleChoiceQuiz: View {
//* TERMINAL CODE START *//

/* Placeholder Variables */
/// Total # of Answer Buttons.
@State private var allAnswerButtons: Int = 3
/// Increases Certain Variables by 1 for every Correct Answer.
@State private var correctPoint: Int = 1
/// Increases Certain Variables by 1 for every Question Answered.
@State private var questionProgressor: Int = 1
/// Null # of Multipliers.
@State private var noMultipliers: Int = 0
/// Minimum Size Multiplier.
@State private var minMultiplier: Double = 0.25
/// Maximum Size Multiplier.
@State private var maxMultiplier: Double = 3.00
/// Size Increments of Multiplier Range.
@State private var multiplierIncrement: Double = 0.25
/// Value of Multiplier that keeps Current # of Points Identical.
@State private var identicalMultiplier: Double = 1.0
/// Use of a Multiplier.
@State private var multiplierUse: Int = 1
/// Offsets currentListIndex Independently to indicate the Current Question more clearly.
@State private var offsettorToCurrent: Int = 1
/// Minimum Formulae Question.
@State private var minQuestionForm: Int = 0
/// Maximum Formulae Question.
@State private var maxQuestionForm: Int = 4
/// Minimum Triangular Centre Question.
@State private var minQuestionTricent: Int = 5
/// Maximum Triangular Centre Question.
@State private var maxQuestionTricent: Int = 7
/// Resets Scroller Variables.
@State private var scrollerReset: Int = 0
/// Compares Numbers Against Self for Pluralism.
@State private var singlePlural: Double = 1.0

/* Plural Variables */
/// Single Letter to accurately follow single-letter pluralism when needed in TERMINAL.
@State private var pluralS: String = ""
/// "Be" Past-Tense to accurately follow "Be" Past-Tense pluralism when needed in TERMINAL.
@State private var pluralWasWere: String = "was"

/* Points System */
/// Total Sum/Product of Points Accumulated/Decumulated.
@State private var pointTotal: Double = 0
/// Displays and Confirms Answer validity including total number of Points having been affected by button responses, in TERMINAL. Starts specifically as "Points: 0" because no Questions or Multipliers have been Answered/Used yet.
@State private var pointDisplay: String = "Points: 0"
/// Total Number of Questions Answered Correctly.
@State private var correctTotal: Int = 0

/* Quiz Progress State */
/// Index Number of Current Question & indirectly, Correct Answer.
@State private var currentListIndex: Int = 0
/// Shuffled List of 8 Indexes to Shuffle Order of Connected Questions and Correct Answers.
@State private var randomIndexOrder: [Int] = Array(0..<8).shuffled()
/// Checks for End of Quiz.
@State private var quizEnded = false

/* Multiplier State */
// Randomized multiplier to affect the Point Total. Starts displayed as 1 to show that the Point Total has not yet been significantly affected in TERMINAL.
@State private var pointMultiplier: Double = 1.0
// Ensures multiplyPoints() can only be used once per Question on average.
@State private var multiplierAttempts: Int = 0
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
// /// Fixed list of questions.
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
// /// Fixed list of answers.
// let answerList = [
//     "(x2-x1, y2-y1)",
//     "(y2-y1)/(x2-x1)",
//     "(x1+x2, y1+y2)/2",
//     "y=mx+c",
//     "a/b -> -(b/a)",
//     "Tri-intersection point of a triangle based on lines from midpoints to directly opposite vertices",
//     "Tri-intersection point of a triangle based on lines from perpendicular bisector midpoints",
//     "Tri-intersection point of a triangle based on lines from perpendicular bisectors to directly opposite vertices"
// ]
/// Fixed list of questions.
let questionList = [
    "1", "2", "3", "4", "5", "6", "7", "8"
]
/// Fixed list of answers.
let answerList = [
    "1", "2", "3", "4", "5", "6", "7", "8"
]

/// TERMINAL Display.
var body: some View {
    VStack(alignment: .center, spacing: 1) {
        // Displays Quiz Progress.
        Text("--- \(currentQuestionDisplay) ---")
        // Three Buttons containing one Answer each.
        if currentAnswerList.count == allAnswerButtons {
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
    /// Displays First Question on Startup.
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
        pointTotal += Double(correctPoint)
        correctTotal += correctPoint
        // Confirms Correctness of Answer with changed Point Total.
        updatePoints(suffixing: "Correct answer! You now")
    } else {
        // Confirms Wrongness of Answer with unchanged Point Total.
        updatePoints(suffixing: "Wrong answer! you still")
    }
    // Progresses Question after Current Answer Picked.
    currentListIndex += questionProgressor
    // Displays next Question after Current Answer Picked.
    nextQuestion()
}

/*
: Multiplies Points by a random amount. Both decreasing and increasing Multipliers.
*/
func multiplyPoints() {
    if multiplierAttempts != noMultipliers {
        // Randomizes multiplier from a range of 0.25-3.00, in increments of 0.25.
        pointMultiplier = Array(stride(from: minMultiplier, through: maxMultiplier, by: multiplierIncrement)).randomElement()!
        // Privately copies pointTotal specifically for effective compatibility with pointMultiplier.
        pointTotal *= pointMultiplier
        if pointMultiplier == identicalMultiplier {
            // Updates Point Display to reflect ineffective Multiplier.
            updatePoints(suffixing: "You still")
        } else {
            // Updates Point Display to reflect effective Multiplier.
            updatePoints(suffixing: "You now")
        }
        // Subtracts Multiplier after use.
        multiplierAttempts -= multiplierUse
    }
    // Adapts multiplierDisplay based on Subtraction of a Multiplier.
    updateMultipliers()
}

/*
: Updates Points with a Reason Statement.
: - Parametres:
:   - reasonStatement: Reason prefixing how pointTotal was actively changed.
:   - pointVariant: Chosen Variable Type to represent # of Points in pointDisplay.
*/
func updatePoints(suffixing reasonStatement: String) {
    // Checks if pointTotal is numerically either singular or plural after Effect contextualized by reasonStatement.
    adaptPlural(using: pointTotal)
    /// Privately copies pluralS specifically to adapt "point/points".
    var pointPlural = pluralS
    // Confirms reason of changed pointVariant all displayed in TERMINAL.
    pointDisplay = "\(reasonStatement) have \(pointTotal) point\(pointPlural)!"
}

/*
: Updates Multiplier Attempt Total.
*/
func updateMultipliers() {
    /// Privately copies multiplierAttempts specifically for checking by adaptPlural().
    var decimalMultiplierAttempts = Double(multiplierAttempts)
    /// Adapts pluralS based on Addition/Subtraction of a Multiplier.
    adaptPlural(using: decimalMultiplierAttempts)
    /// Privately copies pluralS specifically to adapt "multiplier/multipliers" after Addition/Subtraction of a Multiplier.
    var multiplierPlural = pluralS
    // Updates multiplierDisplay to reflect Multiplier Subtraction.
    multiplierDisplay = "You have \(multiplierAttempts) Multiplier\(multiplierPlural)! Answer more questions to earn more Multipliers!"
}

/*
: Sets up Next Question, or displays Summary if Quiz has ended.
*/
func nextQuestion() {
    // Stops Addition of Multipliers once Quiz has Ended.
    if quizEnded == false {
        // Introduces multiplierDisplay on Startup and later adapts based on Subtraction of a Multiplier.
        updateMultipliers()
        // Adds one Multiplier per Question Answered.
        multiplierAttempts += questionProgressor
    }

    // Checks if all Questions have been Answered.
    if currentListIndex >= randomIndexOrder.count {
        // Confirms and Displays Quiz Completion. Fixed number of Total Questions = adaptPlural() unneeded for "question/->questions<-" and “was/->were<-”.
        currentQuestionDisplay = "All questions answered! \(correctTotal)/\(randomIndexOrder.count) questions were answered correctly!"
        // Credits Creator while also disabling Progressible Question-Answer Connectivity.
        currentAnswerList = ["Made", "By", "Kabs!"]
        // Displays Final Score. Fixed number of Total Questions = adaptPlural() unneeded for “point/->points<-”.
        pointDisplay = "Your final score sums to \(pointTotal)/\(randomIndexOrder.count) points!"
        // Confirms that Quiz has Ended.
        quizEnded = true
    } else {
        /// Picks shuffled index from [randomIndexOrder], according to current knowledgeable content progression of quiz.
        var randomListIndex = randomIndexOrder[currentListIndex]
        // Picks Next Question using randomListIndex, for Next Question Display.
        currentQuestionDisplay = "[\(correctTotal)/\(randomIndexOrder.count)] \(currentListIndex+offsettorToCurrent). \(questionList[randomListIndex])"
        // Sets up Correct Answer Connected to Next Question.
        correctAnswer = answerList[randomListIndex]

        /// Container for Three Answers before Shuffling.
        var possibleAnswerList: [String] = ["Incorrect","Answers"]

        if randomListIndex >= minQuestionTricent && randomListIndex <= maxQuestionTricent {
            /* Answer Category: Triangular Centre */
            // Instant 3 Answers with only 1 always Correct and no Duplicates.
            possibleAnswerList = Array(answerList[minQuestionTricent...maxQuestionTricent])
        } else {
            /* Answer Category: Formulae */
            /// Container for more than Three Answers (Formulae Answer Category), to be cut down.
            var otherAnswerList = Array(answerList[minQuestionForm...maxQuestionForm])

            /// Increases Scroller Variables by 1 for every Element in a List.
            var listScroller: Int = 1
            /// Used to scroll through 2-Element Arrays.
            var twoScroller = scrollerReset
            /// Used to scroll through 5-Element Arrays.
            var fiveScroller = scrollerReset

            // Scrolls through Formulae Answer Category to...
            for otherAnswer in otherAnswerList {
                // ...Search for the Correct Answer according to Current Question to...
                if otherAnswer == correctAnswer {
                    // ...Remove Correct Answer to leave all Incorrect Answers left.
                    otherAnswerList.remove(at: fiveScroller)
                }
                // Prepares Loop to Search Next otherAnswers.
                fiveScroller += listScroller
            }
            // Shuffles List of all Incorrect (Formulae) Answers.
            otherAnswerList.shuffle()

            /// Sets up 3-Answer (Formulae) List for Next Question.
            for possibleAnswerSingle in possibleAnswerList {
                // Adds 2 Incorrect Answers First.
                possibleAnswerList[twoScroller] = otherAnswerList[twoScroller]
                // Prepares Loop to Collect Second Incorrect Answer.
                twoScroller += listScroller
            }
            // Adds 1 Correct Answer Last.
            possibleAnswerList.append(correctAnswer)
        }
        // Shuffles Complete Answer List for Maximum Non-Cheesability, for Next Question.
        currentAnswerList = possibleAnswerList.shuffled()
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
    if numericUnit == singlePlural {
        // Words should grammatically be singular.
        pluralS = ""
        pluralWasWere = "was"
    } else {
        // Words should grammatically be plural.
        pluralS = "s"
        pluralWasWere = "were"
    }
}
//* TERMINAL CODE END *//
}