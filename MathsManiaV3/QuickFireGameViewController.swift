//
//  QuickFireGameViewController.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 03/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class QuickFireGameViewController: UIViewController {

    // The object which holds what operator the user selected
    
    var GameMode = String()
    
    // The object that holds our users answer rather than ripping it from the label everytime
    
    var Answer2Question = String()
    
    // An object to hold wether the game has started
    
    var GameStarted = false
    
    // Variable for the starting countdown timer
    
    var startTimer: Timer!
    
    // Variable for counting how long is left in the start timer
    
    var count = 0
    
    // Timer for controlling the seconds left that are shown on the screen
    
    var SecondsTimer: Timer!
    
    // Variable for how many seconds the user starts with
    
    var extraSeconds = 5.0
    
    // a var to hold the question the user faces
    
    var QuestionFaced = ""
    
    // Variable for holding the correct answer for the users question
    
    var CorrectAnswer = 0
    
    // Timer that controlls the checking of answers
    
    var GameTimer: Timer!
    
    // Variable for holding the users score
    
    var userScore = 0
    
    // Var for if the high score is broken
    
    var highScoreBroken = false
    
    // Var for holding the previous high score
    
    var previousHighscore = 0
    
    // For generating random numbers
    
    var numberOne_int = Int()
    var numberTwo_int = Int()
    var numberOne_text = String()
    var numberTwo_text = String()
    
    // Outlets of all of the buttons we need to interact with
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    @IBOutlet weak var Button9: UIButton!
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var ClearButton: UIButton!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var AnswerBox: UILabel!
    @IBOutlet weak var NumberOne: UILabel!
    @IBOutlet weak var NumberTwo: UILabel!
    @IBOutlet weak var Operator: UIImageView!
    @IBOutlet weak var QuickFireModeTitle: UILabel!
    @IBOutlet weak var AnswerViewBox: UIView!
    
    
    
    
    
    @IBAction func AddNumber(_ sender: UIButton) {
        let existing_answer = Answer2Question
        let num = sender.currentTitle!
        let new_answer = existing_answer + num
        // Updating the variable answer so our input is saved
        Answer2Question = new_answer
        AnswerBox.text = new_answer
    }
    
    @IBAction func ClearAnswerBox(_ sender: UIButton) {
        AnswerBox.text = ""
        Answer2Question = ""
    }
    
    @IBAction func StartButton(_ sender: Any) {
        // Checking to see if the game has started
        if GameStarted == false{
            // Disable button to stock double clicks
            StartButton.isEnabled = false
            // Countdown start timer
            startTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ShowStartTimer), userInfo: nil, repeats: true)
        }
        else{
            
            // The button will now be functioning as a clear one button
            
            let truncated_answer = String(Answer2Question.dropLast())
            Answer2Question = truncated_answer
            AnswerBox.text = Answer2Question
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Adding the background to the application
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Leaderboard")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        disableButtons()
    }
    
    @objc func ShowStartTimer(){
        // Adding one to the count and displaying it
        count += 1
        
        if count == 1{
            AnswerBox.text = "3"
        }
        if count == 2{
            AnswerBox.text = "2"
        }
        if count == 3{
            AnswerBox.text = "1"
        }


        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            self.StartButton.isEnabled = true
            // Change start and clear buttons into clear one and all clear
            self.StartButton.setTitle("Clear", for: UIControl.State.normal)
            let colour = self.ClearButton.backgroundColor
            self.StartButton.backgroundColor = colour
            self.ClearButton.setTitle("ALL Clear", for: UIControl.State.normal)
            // Invalidate the timer as the start timer has ended
            self.startTimer.invalidate()
        }
        
        // Tried making game_started = true under where i invalidate timer but that didnt seem to work so instead of checking if the game has started it checks when the count is 4 thus past the 3 second countdown
        
        if count == 4{
            GameStarted = true
            // Enable buttons so user can play
            enableButtons()
            AnswerBox.text = ""
            genQuestions()
            SecondsTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ChangeSeconds), userInfo: nil, repeats: true)
            GameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: true)
            
        }
        
    }
    
    @objc func ChangeSeconds(){
        extraSeconds = extraSeconds - 0.01
        if extraSeconds > 7.5{extraSeconds = 7.5}
        
        let str_Seconds = String(extraSeconds)
        
        // for some reason it doesnt like doing - 0.01 so i just get the first 4 digits instead to clean it up
        
        QuickFireModeTitle.text = String(str_Seconds.prefix(4))
        
        let darkGreen = hexStringToUIColor(hex: "#20992a")
        let darkLightGreen = hexStringToUIColor(hex: "#5ab832")
        let lightGreen = hexStringToUIColor(hex: "#90bf3f")
        let yellowGreen = hexStringToUIColor(hex: "#bdb74d")
        let yellow = hexStringToUIColor(hex: "#d4ad20")
        let orange = hexStringToUIColor(hex: "#e8992a")
        let orangeRed = hexStringToUIColor(hex: "#e6671e")
        let red = hexStringToUIColor(hex: "#e8291c")

        
        if extraSeconds > 4.6 {QuickFireModeTitle.textColor = darkGreen}
        else if extraSeconds > 4.2 {QuickFireModeTitle.textColor = darkLightGreen}
        else if extraSeconds > 3.5 {QuickFireModeTitle.textColor = lightGreen}
        else if extraSeconds > 3 {QuickFireModeTitle.textColor = yellowGreen}
        else if extraSeconds > 2.7 {QuickFireModeTitle.textColor = yellow}
        else if extraSeconds > 2.3 {QuickFireModeTitle.textColor = orange}
        else if extraSeconds > 1.8 {QuickFireModeTitle.textColor = orangeRed
            QuickFireModeTitle.shakeit()}
        else if extraSeconds > 1.2 {QuickFireModeTitle.textColor = red
            QuickFireModeTitle.shakeit()}
        else if extraSeconds < 0{
            SecondsTimer.invalidate()
            extraSeconds = 0
            QuickFireModeTitle.textColor = UIColor.white
            QuickFireModeTitle.text = String(extraSeconds)
            
        }
        
        
    }
    
    // Function that generates a random addition question
    
    func genQuestions(){
        if GameMode == "Plus"{genQuestionPlus()}
        if GameMode == "Minus"{genQuestionMinus()}
        if GameMode == "Divide"{genQuestionDivide()}
        if GameMode == "Multiply"{genQuestionMultiply()}
    }
    
    func genQuestionPlus(){
        
        let (numberOne_text, numberTwo_text, numberOne_int, numberTwo_int) = GenRandomNumbers()
        
        // Find the bigger number and place that first
        
        if numberOne_int > numberTwo_int{
            NumberOne.text = numberOne_text
            NumberTwo.text = numberTwo_text
            Operator.image = UIImage(named:"Plus")
            CorrectAnswer = numberOne_int + numberTwo_int
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberOne_text + " " + "+" + " " + numberTwo_text + " " + "=" + " " + str_ans
        }else{
            NumberOne.text = numberTwo_text
            NumberTwo.text = numberOne_text
            Operator.image = UIImage(named:"Plus")
            CorrectAnswer = numberOne_int + numberTwo_int
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberTwo_text + " " + "+" + " " + numberOne_text + " " + "=" + " " + str_ans
        }
    }
    
    func genQuestionMinus(){
        
        let (numberOne_text, numberTwo_text, numberOne_int, numberTwo_int) = GenRandomNumbers()
        
        // Find the bigger number and place that first
        
        if numberOne_int > numberTwo_int{
            NumberOne.text = numberOne_text
            NumberTwo.text = numberTwo_text
            Operator.image = UIImage(named:"Minus")
            CorrectAnswer = numberOne_int - numberTwo_int
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberOne_text + " " + "-" + " " + numberTwo_text + " " + "=" + " " + str_ans
        }else{
            NumberOne.text = numberTwo_text
            NumberTwo.text = numberOne_text
            Operator.image = UIImage(named:"Minus")
            CorrectAnswer = numberTwo_int - numberOne_int
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberTwo_text + " " + "-" + " " + numberOne_text + " " + "=" + " " + str_ans
        }
    }
    
    func genQuestionDivide(){
        
        let (numberOne_text, numberTwo_text, numberOne_int, numberTwo_int) = GenRandomNumbers()
        
        // Find the bigger number
        
        if numberOne_int > numberTwo_int{
            let numberThree_int = numberOne_int * numberTwo_int
            let numberThree_text = String(numberThree_int)
            NumberOne.text = numberThree_text
            NumberTwo.text = numberOne_text
            Operator.image = UIImage(named:"Divide")
            CorrectAnswer = numberTwo_int
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberThree_text + " " + "/" + " " + numberOne_text + " " + "=" + " " + str_ans
            
        }else{
            let numberThree_int = numberOne_int * numberTwo_int
            let numberThree_text = String(numberThree_int)
            NumberOne.text = numberThree_text
            NumberTwo.text = numberTwo_text
            Operator.image = UIImage(named:"Divide")
            CorrectAnswer = numberOne_int
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberThree_text + " " + "/" + " " + numberTwo_text + " " + "=" + " " + str_ans
        }
    }
    
    func genQuestionMultiply(){
        
        let (numberOne_text, numberTwo_text, numberOne_int, numberTwo_int) = GenRandomNumbers()
        
        if numberOne_int > numberTwo_int{
            NumberOne.text = numberOne_text
            NumberTwo.text = numberTwo_text
            CorrectAnswer = numberOne_int * numberTwo_int
            Operator.image = UIImage(named:"Times")
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberOne_text + " " + "x" + " " + numberTwo_text + " " + "=" + " " + str_ans
        }else{
            NumberOne.text = numberTwo_text
            NumberTwo.text = numberOne_text
            CorrectAnswer = numberOne_int * numberTwo_int
            Operator.image = UIImage(named:"Times")
            let str_ans = String(CorrectAnswer)
            QuestionFaced = numberTwo_text + " " + "x" + " " + numberOne_text + " " + "=" + " " + str_ans
        }
    }
    
    func GenRandomNumbers() -> (String, String, Int, Int){
        
        // Variables for individual numbers
        
        var firstInt = Int()
        var secondInt = Int()
        var thirdInt = Int()
        var fourthInt = Int()
        
        if GameMode == "Multiply"{
            numberOne_int = Int.random(in: 0..<13)
            numberTwo_int = Int.random(in: 0..<13)
            numberOne_text = String(numberOne_int)
            numberTwo_text = String(numberTwo_int)
        };if GameMode == "Divide"{
            numberOne_int = Int.random(in: 1..<13)
            numberTwo_int = Int.random(in: 0..<13)
            numberOne_text = String(numberOne_int)
            numberTwo_text = String(numberTwo_int)
        }else{
            firstInt = Int.random(in: 1..<10)
            secondInt = Int.random(in: 0..<10)
            thirdInt = Int.random(in: 1..<10)
            fourthInt = Int.random(in: 0..<10)
            numberOne_text = String(firstInt) + String(secondInt)
            numberTwo_text = String(thirdInt) + String(fourthInt)
            
            numberOne_int = Int(numberOne_text)!
            numberTwo_int = Int(numberTwo_text)!
        }
        
        return (numberOne_text, numberTwo_text, numberOne_int, numberTwo_int)
    }
  
    @objc func checkAnswer(){
        extraSeconds -= 0.5
        let UserAnswer = Int(Answer2Question)
        if extraSeconds < 0 {
            if UserAnswer == CorrectAnswer{
                extraSeconds += 4
                AnswerBox.text = ""
                Answer2Question = ""
                userScore += 1
                genQuestions()
            }else{
                disableButtons()
                GameTimer.invalidate()
                let Popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popup") as! popupViewController
                let Leader = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Leaderboard") as! LeaderboardViewController
                if GameMode == "Plus"{previousHighscore = UserDefaults.standard.integer(forKey : "highscorePlus")}
                if GameMode == "Minus"{previousHighscore = UserDefaults.standard.integer(forKey : "highscoreMinus")}
                if GameMode == "Divide"{previousHighscore = UserDefaults.standard.integer(forKey : "highscoreDivide")}
                if GameMode == "Multiply"{previousHighscore = UserDefaults.standard.integer(forKey : "highscoreMultiply")}
                if GameMode == "All"{previousHighscore = UserDefaults.standard.integer(forKey : "highscoreAll")}
                
                if userScore > previousHighscore{
                    if GameMode == "Plus"{
                        UserDefaults.standard.set(userScore, forKey: "highscorePlus")
                        Leader.highScore = UserDefaults.standard.integer(forKey : "highscorePlus")
                    }
                    if GameMode == "Minus"{
                        UserDefaults.standard.set(userScore, forKey: "highscoreMinus")
                        Leader.highScore = UserDefaults.standard.integer(forKey : "highscoreMinus")
                    }
                    if GameMode == "Divide"{
                        UserDefaults.standard.set(userScore, forKey: "highscoreDivide")
                        Leader.highScore = UserDefaults.standard.integer(forKey : "highscoreDivide")
                    }
                    if GameMode == "Multiply"{
                        UserDefaults.standard.set(userScore, forKey: "highscoreMultiply")
                        Leader.highScore = UserDefaults.standard.integer(forKey : "highscoreMultiply")
                    }
                    if GameMode == "All"{
                        UserDefaults.standard.set(userScore, forKey: "highscoreAll")
                        Leader.highScore = UserDefaults.standard.integer(forKey : "highscoreAll")
                    }
                    
                    highScoreBroken = true
                    
                    // Update previous highscore
                    
                    previousHighscore = userScore
                
                }
                    if highScoreBroken == true{
                        // We want to also tell the user he has a new high score
                        Popup.highScore = previousHighscore
                        let highscorestr = "New High Score!"
                        Popup.high = highscorestr
                    }else{
                        let highscorestr = "High Score"
                        Popup.high = highscorestr
                    }
                    
                    Popup.QFaced = QuestionFaced
                    Popup.highScore = previousHighscore
                    Popup.userScore = userScore
                    self.addChild(Popup)
                    // ensuring the popup frame is the same as the main view frame
                    Popup.view.frame = self.view.frame
                    //adding the popup to the view
                    self.view.addSubview(Popup.view)
                    Popup.didMove(toParent: self)
                
            }
        }
        
        if UserAnswer == CorrectAnswer{
            extraSeconds += 4
            Answer2Question = ""
            AnswerBox.text = ""
            userScore += 1
            genQuestions()
        }else{
            let str_correctAnswer = String(CorrectAnswer)
            if Answer2Question.count == str_correctAnswer.count{
                AnswerViewBox.shake()
        }
        }
        
    }
    
    @objc func disableButtons(){
        
        Button1.isEnabled = false
        Button1.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button2.isEnabled = false
        Button2.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button3.isEnabled = false
        Button3.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button4.isEnabled = false
        Button4.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button5.isEnabled = false
        Button5.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button6.isEnabled = false
        Button6.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button7.isEnabled = false
        Button7.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button8.isEnabled = false
        Button8.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button9.isEnabled = false
        Button9.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        ClearButton.isEnabled = false
        ClearButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        Button0.isEnabled = false
        Button0.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        
    }
    
    func enableButtons(){
        Button1.isEnabled = true
        Button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button2.isEnabled = true
        Button2.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button3.isEnabled = true
        Button3.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button4.isEnabled = true
        Button4.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button5.isEnabled = true
        Button5.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button6.isEnabled = true
        Button6.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button7.isEnabled = true
        Button7.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button8.isEnabled = true
        Button8.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button9.isEnabled = true
        Button9.setTitleColor(UIColor.black, for: UIControl.State.normal)
        ClearButton.isEnabled = true
        ClearButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        Button0.isEnabled = true
        Button0.setTitleColor(UIColor.black, for: UIControl.State.normal)
    }


}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

public extension UILabel {

    func shakeit(count : Float = 9,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
