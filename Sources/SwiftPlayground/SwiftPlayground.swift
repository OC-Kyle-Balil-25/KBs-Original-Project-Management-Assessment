// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
        struct SwiftPlayground {
                static func main() {
//// General Variables

/// Increases by 1 for every looparound to progress certain variables in said loops
var loopScroller = 0

var scoreStat = 0

/// Fixed list of questions
var questionList = [
    "What is the formula for finding the distance between two points?",
    "What is the formula for finding the gradient between two points?",
    "What is the formula for finding the midpoint between two points?",
    "What is the equation of a linear line?",
    "How do you find the negative reciprocal of a gradient?",

    "What is the Centroid?",
    "What is the Circumcentre?",
    "What is the Orthocentre?"
]
/// Copy of questionList, but shuffled
var questionListRandom = questionList.shuffled()

/// Fixed list of answers
var answerList = [
    "(x2-x1, y2-y1)",
    "(y2-y1)/(x2-x1)",
    "(x1+x2, y1+y2)/2",
    "y=mx+c",
    "(a/b -> -a/b or a/-b)",

    "Tri-intersection point of a triangle based on lines from midpoints to directly opposite vertices",
    "Tri-intersection point of a triangle based on lines from perpendicular bisector midpoints",
    "Tri-intersection point of a triangle based on lines from perpendicular bisectors to directly opposite vertices",
]

/*
Provides a list of three cateredly order-randomized answers.
*/
func randomizeAnswers() {
    // Shuffles the given group of answers
    answerRange.shuffled()
    /// Placeholder array to hold three given answers.
    var randomAnswers: [String] = ["","",""]
    // Scrolls through each empty choice in randomAnswers
    for randomAnswer in randomAnswers {
        // Pulls out a random answer from answerRange and inserts it into the respective index of the current looparound
        randomAnswers[loopScroller] = answerRange.randomElement()!
        // Prepares loopScroller for next looparound
        loopScroller += 1
    }
    // Resets loopScroller for next question
    loopScroller = 0
    // Prints out the three answers in a numbered list
    print (randomAnswers)
}

/// Holds one of two categories of unedited answers. Varred here with placeholder content to allow function recognition
var answerRange = ["1","2","3"]
// Goes through every question in the quiz
for questionConst in questionListRandom {
    // Converts each question string from a constant to a variable
    var questionVar = questionConst
    // Randomizes the order from one of two fixed sets of answers (limited down to 3) based on the question provided. Ordered in reverse for efficiency.
    if questionVar == questionList[5] || questionVar == questionList[6] || questionVar == questionList[7] {
        // Answer Category: Formulae
        answerRange = Array(answerList[5...7])
        randomizeAnswers()
    } else {
        // Answer Category: Triangular Center
        answerRange = Array(answerList[0...4])
        randomizeAnswers()
    }
}

// var scoreMultiplier = Array(stride(from: 0.25, through: 3, by: 0.25)).randomElement()!
// print (scoreMultiplier)
                }
        }