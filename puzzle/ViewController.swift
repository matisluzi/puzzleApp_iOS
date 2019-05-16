//
//  ViewController.swift
//  puzzle single
//
//  Created by Matis Luzi on 5/12/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var letters: [UIButton]!
    @IBOutlet weak var wordLettersLabel: UILabel!
    @IBOutlet weak var finalUserWordLabel: UILabel!
    @IBOutlet weak var userWordCorrect: UILabel!
    @IBOutlet weak var letterCountHelp: UILabel!
    @IBOutlet weak var helpMe: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var wordsLeft: UILabel!
    @IBOutlet weak var levelNumberLabel: UILabel!
    
    
    var arrayLength: Int = 0
    var randNum: Int = 0
    
    var level_word = ["kujtim", "ndryshe", "siguri"]
    var level_list: Dictionary<Int, Array<String>> = [
        0: ["kujtim","ujk","mik","ik","kujt","ti","ju","ku"],
        1: ["ndryshe","dy","dyshe","ne","dry","re","sy"],
        2: ["siguri","gur","si","gris"]]
    var wordListUnlockable: Array<String> = []
    var fullWord = ""
    
    var level = 0
    
    var wordLetters: Array<Character> = []
    var wordLettersString: Array<String> = []
    
    var buttons: Array<UIButton> = []
    var length: Array<Int> = []
    var column = 1
    
    var wordsLeftValue: Int = 0
    
    //=============================
    //=============================
    //=============================
    // VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        for i in 0...11{
            self.letters[i].titleLabel!.minimumScaleFactor = 0.5
            self.letters[i].titleLabel!.numberOfLines = 0;
            self.letters[i].titleLabel!.adjustsFontSizeToFitWidth = true;
        }
        
        helpMe.layer.cornerRadius = 10
        goButton.layer.cornerRadius = 10
        
        wordListUnlockable = level_list[level]!
        arrayLength = level_list[level]!.count
        randNum = Int.random(in: 0..<arrayLength)
        letterHelp(randNum: randNum)
        
        length = [level_word[0].count, level_word[1].count, level_word[2].count]
        
        self.finalUserWordLabel.isHidden = true
        self.userWordCorrect.isHidden = true
        self.wordLettersLabel.isHidden = true
        
        wordsLeftValue = wordListUnlockable.count
        self.wordsLeft.text = "Fjalët e mbetura për këtë nivel: \(wordsLeftValue)"
        
        self.levelNumberLabel.text = "Niveli \(level+1)"
        
        gameLevel()
        
    }
    
    //=============================
    //=============================
    //=============================
    
    var pos = 0
    var userLetters: Array<String> = []
    @IBAction func buttonPressed(sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        switch button.tag {
        case 0:
            startWord(letterChosen: 0, position: pos)
            pos += 1
        case 1:
            startWord(letterChosen: 1, position: pos)
            pos += 1
        case 2:
            startWord(letterChosen: 2, position: pos)
            pos += 1
        case 3:
            startWord(letterChosen: 3, position: pos)
            pos += 1
        case 4:
            startWord(letterChosen: 4, position: pos)
            pos += 1
        case 5:
            startWord(letterChosen: 5, position: pos)
            pos += 1
        case 6:
            startWord(letterChosen: 6, position: pos)
            pos += 1
        case 7:
            startWord(letterChosen: 7, position: pos)
            pos += 1
        case 8:
            startWord(letterChosen: 8, position: pos)
            pos += 1
        case 9:
            startWord(letterChosen: 9, position: pos)
            pos += 1
        case 10:
            startWord(letterChosen: 10, position: pos)
            pos += 1
        case 11:
            startWord(letterChosen: 11, position: pos)
            pos += 1
            
        default:
            return
        }
    }
    var userWord: String = ""
    @IBAction func goButtonPressed(_ sender: Any) {
        userWord = userLetters.joined()
        if wordListUnlockable.contains(userWord) {
            self.finalUserWordLabel.text = "Fjala juaj është \"\(userWord)\"."
            self.userWordCorrect.text = "Ajo është e saktë."
            self.userWordCorrect.textColor = UIColor(red:0.02, green:0.74, blue:0.00, alpha:1.0)
            wordListUnlockable.firstIndex(of: userWord).map { wordListUnlockable.remove(at: $0) }
            
            reset()
            
            arrayLength = wordListUnlockable.count
            randNum = Int.random(in: 0..<arrayLength)
            letterHelp(randNum: randNum)
        }
        else {
            self.finalUserWordLabel.text = "Fjala juaj është \"\(userWord)\"."
            self.userWordCorrect.text = "Ajo është e gabuar."
            self.userWordCorrect.textColor = UIColor.red
            reset()
            
        }
        self.finalUserWordLabel.isHidden = false
        self.userWordCorrect.isHidden = false
        
        
    }
    func startWord(letterChosen: Int, position: Int) {
        userLetters.append(wordLettersString[letterChosen])
        userWord = userLetters.joined()
        self.wordLettersLabel.isHidden = false
        self.wordLettersLabel.text = userWord
    }
    
    func reset(){
        if wordListUnlockable.isEmpty {
            level += 1
            gameLevel()
        }
        userWord = ""
        userLetters.removeAll()
        wordLetters.removeAll()
        pos = 0
        self.wordLettersLabel.isHidden = true
        wordsLeftValue = wordListUnlockable.count
        self.wordsLeft.text = "Fjalët e mbetura për këtë nivel: \(wordsLeftValue)"
    }
    
    func letterHelp(randNum: Int){
        self.letterCountHelp.text = "\(wordListUnlockable[randNum].count) shkronja";
    }
    
    func gameLevel() {
        self.letters[0].isHidden = true
        self.letters[1].isHidden = true
        self.letters[2].isHidden = true
        self.letters[3].isHidden = true
        self.letters[4].isHidden = true
        self.letters[5].isHidden = true
        self.letters[6].isHidden = true
        self.letters[7].isHidden = true
        self.letters[8].isHidden = true
        self.letters[9].isHidden = true
        self.letters[10].isHidden = true
        self.letters[11].isHidden = true
        
        fullWord = level_word[level]
        wordListUnlockable = level_list[level]!
        
        wordLetters = Array(fullWord)
        wordLetters.shuffle()
        wordLettersString = wordLetters.map { String($0) }
        
        
        for i in 0...(length[level]-1){
            self.letters[i].setTitle(wordLettersString[i], for: .normal)
            self.letters[i].isHidden = false
        }
            
        self.levelNumberLabel.text = "Niveli \(level+1)"
    }
    
    var helpSelectedWord: String = ""
    var helpSelectedWordArray: Array<Character> = []
    
    
    @IBAction func helpRequested(_ sender: UIButton) {
        helpSelectedWord = wordListUnlockable[randNum]
        helpSelectedWordArray = Array(helpSelectedWord)
        if pos < helpSelectedWordArray.count {
            userLetters.append(String(helpSelectedWordArray[pos]))
            pos+=1
            userWord = userLetters.joined()
            self.wordLettersLabel.isHidden = false
            self.wordLettersLabel.text = userWord
        }
        else {
            UIView.animate(withDuration: 3, animations: {
                self.goButton.backgroundColor = UIColor(red: 0.55, green:0.99, blue:0.55, alpha:1)
            })
            UIView.animate(withDuration: 1) {
                self.goButton.backgroundColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1)
            }
        }
    }
    
}




