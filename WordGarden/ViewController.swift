//
//  ViewController.swift
//  WordGarden
//
//  Created by wxt on 1/29/19.
//  Copyright © 2019 BChacks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var UserGuessLabel: UILabel!
    @IBOutlet weak var guessedletterfield: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playagainbutton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var lettersGuessed = ""
    var wordtoGuess = "CODE"
    var guessCount = 0
    var wrongGuessesRemaining = 8
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessLetterButton.isEnabled = false
        playagainbutton.isHidden = true
    }
    
    func updateUIAfterGues(){
        guessedletterfield.resignFirstResponder()
        guessedletterfield.text = ""
        
    }
    
    func formatUserGuessLabel() {
        var revealedword = ""
        lettersGuessed += guessedletterfield.text!
        for letter in wordtoGuess {
            if lettersGuessed.contains(letter){
                revealedword = revealedword + " \(letter)"
            } else {
                revealedword += " _"
            }
        }
        revealedword.removeFirst()
        UserGuessLabel.text = revealedword
        
    }
    
    func guessAletter(){
        formatUserGuessLabel()
        guessCount += 1
        
        let currentLetterGuessed = guessedletterfield.text!
        if !wordtoGuess.contains(currentLetterGuessed){
           wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedWord = UserGuessLabel.text!
        if wrongGuessesRemaining == 0 {
            playagainbutton.isHidden = false
            guessedletterfield.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !revealedWord.contains("_") {
            // You've won a game!
            playagainbutton.isHidden = false
            guessedletterfield.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            // Update our guess count
            let guess = ( guessCount == 1 ? "Guess" : "Guesses")
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func donekeybuttonPressed(_ sender: UITextField) {
        guessAletter()
        updateUIAfterGues()
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) { if let letterGuessed = guessedletterfield.text?.last{
        guessedletterfield.text = "\(letterGuessed)"
        guessLetterButton.isEnabled = true}
    else {
        guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessAletter()
        updateUIAfterGues()
    }
    @IBAction func PlayAgainButtonPressed(_ sender: UIButton) {
        playagainbutton.isHidden = true
        guessedletterfield.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = 8
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses."
        guessCount = 0
    }
    
}

