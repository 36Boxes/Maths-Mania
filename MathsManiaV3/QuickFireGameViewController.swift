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
    
    // Timer that controlls the checking of answers
    
    var GameTimer: Timer!
    
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
            
            SecondsTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ChangeSeconds), userInfo: nil, repeats: true)
            GameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: true)
            
        }
        
    }
    
    func genQuestion(){
        
        
        
        // Generate 4 random numbers so I can concat them together to form a question
        
        let firstInt = Int.random(in: 1..<10)
        let secondInt = Int.random(in: 0..<10)
        let thirdInt = Int.random(in: 1..<10)
        let fourthInt = Int.random(in: 0..<10)
    }
  
    @objc func checkAnswer(){
        
    }
    
    @objc func ChangeSeconds(){
        extraSeconds = extraSeconds - 0.1
        
        let str_Seconds = String(extraSeconds)
        
        // for some reason it doesnt like doing - 0.01 so i just get the first 4 digits instead to clean it up
        
        QuickFireModeTitle.text = String(str_Seconds.prefix(3))
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
