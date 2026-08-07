// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct SwiftPlayground {
    static func main() {
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

        questionListRandom.shuffle()
        for questionConst in questionListRandom {
            // Converts the question string from a constant to a variable
            var questionVar = questionConst
            if questionVar == questionList[0] || questionVar == questionList[1] || questionVar == questionList[2] || questionVar == questionList[3] || questionVar == questionList[4] {
                print ("Formulae: \(questionVar)")
            } else {
                print ("Triangular Center: \(questionVar)")
            }
        }
    }
}
