// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
        struct SwiftPlayground {
                static func main() {
// General Variables

var pointCount = 0

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
var questionListRandom = questionList

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
var loopScroller = 0

/*
Provides a list of three cateredly order-randomized answers.
*/
// func randomizeAnswers() {
//     answerRange.shuffle()
//     var randomAnswers: [String] = ["","",""]
//     for randomAnswer in 0..<2 {
//     randomAnswers[loopScroller] = answerRange.randomElement()!
//     loopScroller += 1
//     }
//     print (randomAnswers)
// }

// var answerRange = ["1","2","3"]
// questionListRandom.shuffle()
// for questionConst in questionListRandom {
//     // Converts the question string from a constant to a variable
//     var questionVar = questionConst
//     // Randomizes the order from one of two fixed sets of answers (limited down to 3) based on the question provided
//     if questionVar == questionList[5] || questionVar == questionList[6] || questionVar == questionList[7] {
//         var answerRange = Array(answerList[0...4])
//         randomizeAnswers()
//     } else {
//         var answerRange = Array(answerList[5...7])
//         randomizeAnswers()
//     }
// }
// var xpMultiplier = stride(from: 0.25, through: 3, by: 0.25).randomElement()
// print (xpMultiplier)
                }
        }