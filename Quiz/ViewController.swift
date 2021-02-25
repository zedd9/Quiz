//
//  ViewController.swift
//  Quiz
//
//  Created by 신현욱 on 2021/02/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!

    let questions: [String] = ["From what is cognac made?",
                                "What is 7+7?",
                                "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes",
                             "14",
                             "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screemWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screemWidth
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        let scrrenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += scrrenWidth
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 100.0, options: [], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            
            self.updateOffScreenLabel()
        })
    }
}

