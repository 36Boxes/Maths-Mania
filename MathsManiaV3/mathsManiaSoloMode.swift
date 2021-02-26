//
//  mathsManiaSoloMode.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 06/01/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit
import GameKit

class mathsManiaSoloMode: UIViewController  {
    
    // Variable for holding the users answer to the question
    
    var answer_to_Question = ""
    
    // Variable for seeing wether the game has started
    
    var game_started = false
    
    // Variable for the starting countdown timer
    
    var startTimer: Timer!
    
    // Variable for the actual game timer
    
    var gameTimer: Timer!
    
    // Variable for counting how long is left in the start timer
    
    var count = 0
    
    // Variable for holding the correct answer for the users question
    
    var CorrectAnswer = 0
    
    // Variable for how many seconds the user starts with
    
    var extraSeconds = 5.0
    
    // Variable for holding the users score
    
    var userScore = 0
    
    // A variable for holding the type of question that has been chosen
    
    var operationDecider = 0
    
    // A var to check to see if the question is a divide one
    
    var dividingQuestion = false
    
    // A var to check if the question is a multiplication one
    
    var multiplicationQuestion = false

    // A var to check if the question is an addition question
    
    var additionQuestion = false
    
    // A var to check if its a minus question
    
    var minusQuestion = false
    
    // a var to hold the question the user faces
    
    var QuestionFaced = ""
    
    // User defaults to save data after the app closes
    
    let defaults = UserDefaults.standard
    
    // Var for if the high score is broken
    
    var newHigh = false
    
    // Various labels and buttons and views that are displayed and manipulated
    
    @IBOutlet weak var SoloMode: UILabel!
    @IBOutlet weak var Answer: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var oneBut: UIButton!
    @IBOutlet weak var twoBut: UIButton!
    @IBOutlet weak var threeBut: UIButton!
    @IBOutlet weak var fourBut: UIButton!
    @IBOutlet weak var fiveBut: UIButton!
    @IBOutlet weak var sixBut: UIButton!
    @IBOutlet weak var sevenBut: UIButton!
    @IBOutlet weak var eightBut: UIButton!
    @IBOutlet weak var nineBut: UIButton!
    @IBOutlet weak var clearBut: UIButton!
    @IBOutlet weak var zeroBut: UIButton!
    @IBOutlet weak var enterBut: UIButton!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var fiveView: UIView!
    @IBOutlet weak var sixView: UIView!
    @IBOutlet weak var sevenView: UIView!
    @IBOutlet weak var eightView: UIView!
    @IBOutlet weak var nineView: UIView!
    @IBOutlet weak var clearView: UIView!
    @IBOutlet weak var zeroView: UIView!
    @IBOutlet weak var enterView: UIView!
    @IBOutlet weak var numberOne: UILabel!
    @IBOutlet weak var numberTwo: UILabel!
    @IBOutlet weak var minusView: UIImageView!
    @IBOutlet weak var answerViewBox: UIView!
    
    
    // Functions for the number buttons
    
    @IBAction func Add_One(_ sender: UIButton) {
        let existing_answer = answer_to_Question
        // This is to turn it into a string
        let num = sender.currentTitle!
        // Calculate new answer to display
        let new_answer = existing_answer + num
        // Updating the variable answer so our input is saved
        answer_to_Question = new_answer
        // Displaying the answer
        Answer.text = new_answer
    }

    @IBAction func clear(_ sender: UIButton) {
        // Clearing the Answer Box
        Answer.text = ""
        answer_to_Question = ""
    }
    
    @IBAction func enter(_ sender: UIButton) {
        // Checking to see if the game has started
        if game_started == false{
            // Disable button to stock double clicks
            enterBut.isEnabled = false
            // Countdown start timer
            startTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startDisplay), userInfo: nil, repeats: true)
        }
        else{
            // The button will now be functioning as a clear one button
            let truncated_answer = String(answer_to_Question.dropLast())
            answer_to_Question = truncated_answer
            Answer.text = answer_to_Question
        }
    }
    
    // Function that handles the start timer as in displaying and timer
    
    @objc func startDisplay(){
        // Adding one to the count and displaying it
        count += 1
        
        // use the count numbers to display 3-2-1 instead of 1-2-3
        
        if count == 0{
            Answer.text = "Ready?"
        }
        if count == 1{
            Answer.text = "3"
        }
        if count == 2{
            Answer.text = "2"
        }
        if count == 3{
            Answer.text = "1"
        }

        
        // Waiting 3 seconds and then invalidating the timer as the countdown has finished
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            //Clear the answer box
            // Enable button to allow user to submit their question
            self.enterBut.isEnabled = true
            // Change start and clear buttons into clear one and all clear
            self.enterBut.setTitle("Clear", for: UIControl.State.normal)
            self.clearBut.setTitle("ALL Clear", for: UIControl.State.normal)
            // Invalidate the timer as the start timer has ended
            self.startTimer.invalidate()
        }
        
        // Tried making game_started = true under where i invalidate timer but that didnt seem to work so instead of checking if the game has started it checks when the count is 4 thus past the 3 second countdown
        
        if count == 4{
            game_started = true
            // Enable buttons so user can play
            enableButtons()
            Answer.text = ""
            // Call start game function to start generating questions
            genQuestion()
            // Call a timer that checks the answer every second
            gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: true)
            
        }
        
    }
    
    @objc func checkAnswer(){
        // Remove 0.5 seconds from the game timer
        extraSeconds -= 0.5
        // Display the timer
        updateTimerDisplay()
        // If the timer goes below zero it means the user is out of time so the game should end
        if extraSeconds < 0 {
            // Disable the buttons to make it clear the game is over
            disableButtons()
            // Invalidate the timer as the game is over
            gameTimer.invalidate()
            // Show a popup conataining the userscore and questions answered?
            let Popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popup") as! popupViewController
            let Leader = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Leaderboard") as! LeaderboardViewController
            
            let highscore = UserDefaults.standard.integer(forKey : "highscore")
            print(highscore)
            // Calculating wether the score is actually a high score or not
            if userScore > highscore{
                // Saving the highscore and sending it to the popup
                print("NEW HIGH SCORE!")
                newHigh = true
                UserDefaults.standard.set(userScore, forKey: "highscore")
                Leader.highScore = UserDefaults.standard.integer(forKey : "highscore")
            }
            // Updating the userscore for the popup
            print(newHigh, "testing now")
            if newHigh == true{
                // We want to also tell the user he has a new high score
                Popup.highScore = UserDefaults.standard.integer(forKey : "highscore")
                let highscorestr = "New High Score!"
                Popup.high = highscorestr
            }else{
                let highscorestr = "High Score"
                Popup.high = highscorestr}
            Popup.QFaced = QuestionFaced
            Popup.highScore = UserDefaults.standard.integer(forKey : "highscore")
            Popup.userScore = userScore
            self.addChild(Popup)
            // ensuring the popup frame is the same as the main view frame
            Popup.view.frame = self.view.frame
            //adding the popup to the view
            self.view.addSubview(Popup.view)
            Popup.didMove(toParent: self)
            
        }
        // Making the string answer of the user into an integer for comparison use
        if let int_user_answer = Int(answer_to_Question){
            // Check to see if the answer is correct
        if int_user_answer == CorrectAnswer {
            // add seconds to the users time to allow them to continue
            extraSeconds += 3
            // Clearing the answer to the question
            answer_to_Question = ""
            // Clearing the answer box to the question as the user has got the question right
            Answer.text = ""
            // Adding to the score of the user
            userScore += 1
            // Reset all the decider functions
            additionQuestion = false
            minusQuestion = false
            dividingQuestion = false
            multiplicationQuestion = false
            // Generate the next question for display
            genQuestion()
            }
        else{
                // Making the correct answer into a string then comparing users answers length to correct answers length to make it shake if they are the same giving the user the hint
                let str_correctAnswer = String(CorrectAnswer)
                if answer_to_Question.count == str_correctAnswer.count{
                    answerViewBox.shake()
                }
        }
        }
    }
    
    @objc func updateTimerDisplay(){
        // This gets called every 0.5 seconds and checks to see whether the timer has ended
        SoloMode.textColor = UIColor.black
        // Check if extra seconds are over
        if extraSeconds > -0.5 {
            // Display the extra seconds left
        SoloMode.text = String(extraSeconds)
        }
        
    }
    
    @objc func genQuestion(){
        
        // Generate 4 random numbers so I can concat them together to form a question
        
        let firstInt = Int.random(in: 1..<10)
        let secondInt = Int.random(in: 0..<10)
        let thirdInt = Int.random(in: 1..<10)
        let fourthInt = Int.random(in: 0..<10)
        
        // Concat them together and create a string version for displaying
        
        var numberOne_text = String(firstInt) + String(secondInt)
        var numberTwo_text = String(thirdInt) + String(fourthInt)
        
        // Create int versions to use for calculations
        
        guard var numberOne_int = Int(numberOne_text) else{
            
            // These should never be called but its a way to stop the numberInt values from being optionals
            print("BS")
            return
        }
        guard var numberTwo_int = Int(numberTwo_text) else{
            // These should never be called but its a way to stop the numberInt values from being optionals
            print("BS")
            return
        }
        
        // Create random number to decide the operation to use
        operationDecider = Int.random(in: 1..<4)
        print(operationDecider)
        if operationDecider == 1{
            minusQuestion = true
        }
        if operationDecider == 2{
            additionQuestion = true
        }
        if operationDecider == 3{
            multiplicationQuestion = true
        }
        if numberOne_int.isMultiple(of: numberTwo_int){
            dividingQuestion = true
            multiplicationQuestion = false
            additionQuestion = false
            minusQuestion = false
        }
        if numberTwo_int.isMultiple(of: numberOne_int){
            dividingQuestion = true
            multiplicationQuestion = false
            additionQuestion = false
            minusQuestion = false
        }

        // Check if its a dividing question
        if dividingQuestion == true{
            if numberOne_int > numberTwo_int {
                // Display the question
                minusView.image = UIImage(named:"Divide")
                numberOne.text = numberOne_text
                numberTwo.text = numberTwo_text
                // Calculate the correct answer of the question
                if numberOne_int == numberTwo_int {
                    // if the numbers are equal it is easier to put the answer as zero to avoid a fatal error division by zero
                    CorrectAnswer = 1
                }else{CorrectAnswer = numberOne_int / numberTwo_int}
                // Calculate the question faced incase the user gets it wrong to be ready to display later
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberOne_text + " " + "/" + " " + numberTwo_text + " " + "=" + " " + str_ans
            }else{
                // Display the question
                minusView.image = UIImage(named:"Divide")
                numberOne.text = numberTwo_text
                numberTwo.text = numberOne_text
                // Calculate the correct answer of the question
                if numberOne_int == numberTwo_int {
                    // if the numbers are equal it is easier to put the answer as zero to avoid a fatal error division by zero
                    CorrectAnswer = 1
                }else{CorrectAnswer = numberTwo_int / numberOne_int}
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberTwo_text + " " + "/" + " " + numberOne_text + " " + "=" + " " + str_ans
            }
        }
        
        // Check if it is a multiplication question as the code also needs to be ignored if it is
        if multiplicationQuestion == true{
            // Gen a number between 1 - 13 to make it easier
            numberOne_int = Int.random(in: 0..<14)
            numberTwo_int = Int.random(in: 0..<14)
            numberOne_text = String(numberOne_int)
            numberTwo_text = String(numberTwo_int)

            // We now need to display these values so we want to find the larger value and place it first

            if numberOne_int > numberTwo_int {
                // Display the question
                numberOne.text = numberOne_text
                numberTwo.text = numberTwo_text
                // Calculate the correct answer of the question
                CorrectAnswer = numberOne_int * numberTwo_int
                minusView.image = UIImage(named:"Times")
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberOne_text + " " + "x" + " " + numberTwo_text + " " + "=" + " " + str_ans
            }
            else{
                // Display the question
                numberOne.text = numberTwo_text
                numberTwo.text = numberOne_text
                // Calculate the correct answer of the question
                CorrectAnswer = numberTwo_int * numberOne_int
                minusView.image = UIImage(named:"Times")
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberTwo_text + " " + "x" + " " + numberOne_text + " " + "=" + " " + str_ans
            }
        }
        
        if additionQuestion == true {
            // make sure the numbers are reset as sometimes we get the multiplication values
            numberOne_text = String(firstInt) + String(secondInt)
            numberTwo_text = String(thirdInt) + String(fourthInt)

            if numberOne_int > numberTwo_int {
                // Display the question
                numberOne.text = numberOne_text
                numberTwo.text = numberTwo_text
                // Calculate the correct answer of the question and what type of question
                CorrectAnswer = numberOne_int + numberTwo_int
                minusView.image = UIImage(named:"Plus")
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberOne_text + " " + "+" + " " + numberTwo_text + " " + "=" + " " + str_ans

            }else{
                if numberTwo_int > numberOne_int {
                    // Display the question
                    numberOne.text = numberTwo_text
                    numberTwo.text = numberOne_text
                    // Calculate the correct answer of the question and what type of question
                    CorrectAnswer = numberOne_int + numberTwo_int
                    minusView.image = UIImage(named:"Plus")
                    let str_ans = String(CorrectAnswer)
                    QuestionFaced = numberTwo_text + " " + "+" + " " + numberOne_text + " " + "=" + " " + str_ans

                }}
            }
        if minusQuestion == true{
            if numberOne_int > numberTwo_int {
                // Display the question
                minusView.image = UIImage(named:"Minus")
                numberOne.text = numberOne_text
                numberTwo.text = numberTwo_text
                // Calculate the correct answer of the question
                CorrectAnswer = numberOne_int - numberTwo_int
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberOne_text + " " + "-" + " " + numberTwo_text + " " + "=" + " " + str_ans

            }else{
                minusView.image = UIImage(named:"Minus")
                // Display the question
                numberOne.text = numberTwo_text
                numberTwo.text = numberOne_text
                // Calculate the correct answer of the question and what type of question
                CorrectAnswer = numberTwo_int - numberOne_int
                let str_ans = String(CorrectAnswer)
                QuestionFaced = numberTwo_text + " " + "-" + " " + numberOne_text + " " + "=" + " " + str_ans
            }
        }
    }
            
    @IBAction func zero(_ sender: UIButton) {
        let existing_answer = answer_to_Question
        // This is to turn it into a string
        let num = "0"
        // Calculate new answer to display
        let new_answer = existing_answer + num
        // Updating the variable answer so our input is saved
        answer_to_Question = new_answer
        // Displaying the answer
        Answer.text = new_answer
    }
    
    @objc func disableButtons(){
        
        // Lines to disable and change the text colour of buttons
        
        oneBut.isEnabled = false
        oneBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        twoBut.isEnabled = false
        twoBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        threeBut.isEnabled = false
        threeBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        fourBut.isEnabled = false
        fourBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        fiveBut.isEnabled = false
        fiveBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        sixBut.isEnabled = false
        sixBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        sevenBut.isEnabled = false
        sevenBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        eightBut.isEnabled = false
        eightBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        nineBut.isEnabled = false
        nineBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        clearBut.isEnabled = false
        clearBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        zeroBut.isEnabled = false
        zeroBut.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
    }
    

    @objc func enableButtons(){
        
        // Lines to enable and change the text colour of buttons
        
        oneBut.isEnabled = true
        oneBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        twoBut.isEnabled = true
        twoBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        threeBut.isEnabled = true
        threeBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        fourBut.isEnabled = true
        fourBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        fiveBut.isEnabled = true
        fiveBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        sixBut.isEnabled = true
        sixBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        sevenBut.isEnabled = true
        sevenBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        eightBut.isEnabled = true
        eightBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        nineBut.isEnabled = true
        nineBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        clearBut.isEnabled = true
        clearBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
        zeroBut.isEnabled = true
        zeroBut.setTitleColor(UIColor.black, for: UIControl.State.normal)
    }
    
    
    
    let progress = Progress(totalUnitCount: 10)
    let shapeLayer = CAShapeLayer()
    let spade = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Adding the background to the application
        SoloMode.frame.size.height = SoloMode.frame.size.height - SoloMode.font.descender
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "SoloModeBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Adding rounding to the number views
        
        oneView.layer.cornerRadius = 25
        twoView.layer.cornerRadius = 25
        threeView.layer.cornerRadius = 25
        fourView.layer.cornerRadius = 25
        fiveView.layer.cornerRadius = 25
        sixView.layer.cornerRadius = 25
        sevenView.layer.cornerRadius = 25
        eightView.layer.cornerRadius = 25
        nineView.layer.cornerRadius = 25
        zeroView.layer.cornerRadius = 25
        
        // Changing the enter button to start
        
        enterBut.setTitle("Start", for: UIControl.State.normal)
        
        // Disabling Buttons and greying them out to show game has not started
        
        disableButtons()
        
        // Creating circle progress bar
        
        let width = view.frame.width - 20
        let ProgressPath = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: width, height: 50), cornerRadius: 17)
        spade.path = ProgressPath.cgPath
        spade.strokeColor = UIColor.green.cgColor
        spade.lineWidth = 5
        spade.lineCap = CAShapeLayerLineCap.round
        spade.fillColor = UIColor.clear.cgColor
        spade.strokeEnd = 0
        view.layer.addSublayer(spade)
        
        


    

    }
    
    @objc private func HandleTap() {
        print("waste")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 6
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        
        spade.add(basicAnimation, forKey: "basic")
    }
    
    @objc private func enterNum(){
        print("one")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        

    }
}

public extension UIView {

    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}




// Notes for next coding session


// change start to clear one DONE
// add something that makes it different types of questions add subtract times divide but some algorithm has to be created for divide DONE
// sort out ios certificate
// finish the comments
// maybe start on leaderboards?
// high score counter at least DONE
// see if ads can be manipulated in they can using googleadmob NOT DOING THIS GONNA HAVE DONATION BUTTON
// new gamemode maybe? 10s and 5s but very quick
// finish popup aswell more buttons needed DONE
// done??????????? update pending feb 8th 2021
// fix the scaling of the minus


// to figure out localised leaderboards we are gonna have to do something smart, organise counties to a number that i can recognise as a certain county/area, maybe 27 different county leaderboards? if only we could figure out how to host our own one


// make logo spin upon startup if possible?


