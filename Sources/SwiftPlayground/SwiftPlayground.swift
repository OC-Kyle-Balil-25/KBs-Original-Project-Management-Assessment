// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
        struct SwiftPlayground {
                static func main() {
//// General Variables
/// Increases by 1 numeric unit for every looparound to progress numeric displays in Question Category Picker for_in_ Loop. Always scrolls eight times.
var eightScroller = 0
/// Increases by 1 numeric unit for every looparound to progress letterList to display in Answer Shuffler for_in_ Loop. Always scrolls three times.
var threeScroller = 0
/// List of letters in order to list answers.
var letterList = ["A","B","C"]

var scoreStat = 0

/// Fixed list of questions.
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
/// Copy of questionList, but shuffled.
var questionListRandom = questionList.shuffled()

/// Fixed list of answers.
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
Provides a list of three cateredly shuffled answers.
*/
func randomizeAnswers(from minIndex: Int, to maxIndex: Int) {
    // Shuffles the given group of answers.
    answerRange = Array(answerList[minIndex...maxIndex]).shuffled()
    /// Placeholder array to hold three random answers.
    var randomAnswers: [String] = ["","",""]
    // Prints question.
    print ("\(eightScroller). \(questionVar)")
    // Scrolls through each empty choice in randomAnswers.
    for randomAnswer in randomAnswers {
        // Pulls out a random answer from answerRange and inserts it into the respective index of the current looparound.
        randomAnswers[threeScroller] = answerRange[threeScroller]
        // Prints out the three answers in a lettered list
        print ("\(letterList[threeScroller]). \(randomAnswers[threeScroller])")
        // Prepares threeScroller for next looparound.
        threeScroller += 1
    }
    // Resets threeScroller for next question looparound.
    threeScroller = 0
}

/// Holds one of two categories of unedited answers. Varred here with placeholder content to allow function recognition.
var answerRange = ["1","2","3"]
/// Converts each question string from a constant to a variable. Varred here with placeholder content to allow function recognition.
var questionVar = "?"
// Goes through every question in the quiz.
for questionConst in questionListRandom {
    // Prepares eightScroller for printed display in randomizeAnswers.
    eightScroller += 1
    // Converts each question string from a constant to a variable.
    questionVar = questionConst
    // Randomizes the order from one of two fixed sets of answers (limited down to 3) based on the question provided. Ordered in reverse for efficiency.
    if questionList[5...7].contains(questionVar) {
        // Answer Category: Triangular Center
        randomizeAnswers(from: 5, to: 7)
    } else {
        // Answer Category: Formulae
        randomizeAnswers(from: 0, to: 4)
    }
}

// var scoreMultiplier = Array(stride(from: 0.25, through: 3, by: 0.25)).randomElement()!
// print (scoreMultiplier)
                }
        }