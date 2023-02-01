//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var quizLogic = QuizLogic()
    var alreadyOne = false
    var savedScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if quizLogic.checkAnswer(sender.currentTitle!) {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        var _ = quizLogic.nextQuestion()
        updateUI()
    }
    
    private func updateUI() {
        questionTextLabel.text = quizLogic.getCurrentQuestion()
        scoreLabel.text = "Score: \(quizLogic.getCurrentScore())"
        let progressBarValue = quizLogic.getCurrentProgressBarValue()
        
        // MARK: - This is complete shit, but alert is works
        if alreadyOne {
            present(quizLogic.getAlert(score: savedScore), animated: true, completion: nil)
            alreadyOne = false
        }
        
        if progressBarValue == 1.0 {
            alreadyOne = true
            savedScore = quizLogic.getCurrentScore()
        }
        // MARK: -
        
        progressBar.progress = progressBarValue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.trueButton.backgroundColor = UIColor.clear
            self.falseButton.backgroundColor = UIColor.clear
        }
    }
}

