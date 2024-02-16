//
//  GameScreenVC.swift
//  FindFlagApp
//
//  Created by Nebula on 23.10.23.
//

import UIKit

class GameScreenVC: UIViewController {
    
    @IBOutlet weak var ButtonA: UIButton!
    @IBOutlet weak var ButtonC: UIButton!
    @IBOutlet weak var ButtonB: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var IncorrectCount: UILabel!
    @IBOutlet weak var CorrectCount: UILabel!
    
    var questions = [Flags]()
    var incorrectAnswers = [Flags]()
    
    var correctQuestion = Flags()
    
    var questionCounter = 0
    var correctCounter = 0
    var incorrectCounter = 0
    
    var answers = [Flags]()
    var mixAnswers = Set <Flags>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = Flagsdao().random5()
        loadQuestions()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultVC
        resultVC.correctNumber = correctCounter
    }
    
    func loadQuestions() {
        questionNumber.text = "Question \(questionCounter + 1) :"
        CorrectCount.text = "Correct \(correctCounter)"
        IncorrectCount.text = "Incorrect \(incorrectCounter)"
        
        
        correctQuestion = questions[questionCounter]
            
        imageView.image = UIImage(named: correctQuestion.flag_image!)
        
        incorrectAnswers = Flagsdao().random2IncorrectAnswer(flag_id: correctQuestion.flag_id!)
        
        mixAnswers.removeAll()
        mixAnswers.insert(correctQuestion)
        mixAnswers.insert(incorrectAnswers[0])
        mixAnswers.insert(incorrectAnswers[1])
        
        answers.removeAll()
        
        for a in mixAnswers {
            answers.append(a)
        }
        
        ButtonA.setTitle(answers[0].flag_name, for: .normal)
        ButtonB.setTitle(answers[1].flag_name, for: .normal)
        ButtonC.setTitle(answers[2].flag_name, for: .normal)

    }
    
    func checkAnswer(button:UIButton) {
        let buttonText = button.titleLabel?.text
        let CorrectAnswer = correctQuestion.flag_name
        
        if CorrectAnswer == buttonText {
            correctCounter += 1
        } else {
            incorrectCounter += 1
        }
        
        CorrectCount.text = "Correct \(correctCounter)"
        IncorrectCount.text = "Incorrect \(incorrectCounter)"
        
    }
    
    func checkQuestionNumber() {
        questionCounter += 1
        
        if questionCounter != 5 {
            loadQuestions()
        }else{
            performSegue(withIdentifier: "ToResult", sender: nil)
        }
    }
    
    @IBAction func ClickBtnA(_ sender: Any) {
        checkAnswer(button: ButtonA)
        checkQuestionNumber()
    }
    @IBAction func ClickBtnB(_ sender: Any) {
        checkAnswer(button: ButtonB)
        checkQuestionNumber()
    }
    @IBAction func ClickBtnC(_ sender: Any) {
        checkAnswer(button: ButtonC)
        checkQuestionNumber()
    }
}
