//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Mehmet Ergün on 2022-07-26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var yourChoice: UILabel!
    @IBOutlet var computerChoice: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var yourScore: UILabel!
    @IBOutlet var computerScore: UILabel!
    @IBOutlet var paperButton: UIButton!
    @IBOutlet var rockButton: UIButton!
    @IBOutlet var scissorsButton: UIButton!
    
    var yScore = 0
    var cScore = 0
    
    var choosenImage = 0
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images += ["rock", "paper", "scissors"]
        
        
        choosenImage = Int.random(in: 0...2)
        
        imageView.image = UIImage(named: "question")
        
        
        self.resetTime()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(alert(title:message:)))

  
    }
    
    @IBAction func paperTapped(_ sender: UIButton) {
        yourChoice.text = "Paper"
        
        let computer = Choice.randomComputerChoices()
        gameRule(you: .paper, computer: computer)
       
        computerChoice.text = images[choosenImage]
        
        imageView.image = UIImage(named: images[choosenImage])
        
        
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        rockButton.isEnabled = false
        
        self.resetTime()

        
        print(yScore, cScore)
        
        yourScore.text = String(yScore)
        computerScore.text = String(cScore)
        
        if yScore == 10 {
            alert(title: "Hurreeey", message: "You Won")
        }else if cScore == 10 {
            alert(title: "Ooooh!", message: "Computer Won!")
        }
        
    }

    
    
    @IBAction func rockTapped(_ sender: Any) {
        
        yourChoice.text = "rock"
        let computer = Choice.randomComputerChoices()
        gameRule(you: .rock, computer: computer)
        images.shuffle()
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        rockButton.isEnabled = false
        
        computerChoice.text = images[choosenImage]
        imageView.image = UIImage(named: images[choosenImage])

        self.resetTime()
        
        
        
        print(yScore, cScore)
        
        yourScore.text = String(yScore)
        computerScore.text = String(cScore)
        
        if yScore == 10 {
            alert(title: "Hurreeey", message: "You Won")
        }else if cScore == 10 {
            alert(title: "Ooooh!", message: "Computer Won!")
        }
    }
    
    @IBAction func scissorsTapped(_ sender: UIButton) {
        
        yourChoice.text = "Scissors"
        let computer = Choice.randomComputerChoices()
        gameRule(you: .scissors, computer: computer)

        scissorsButton.setTitleColor(UIColor.orange, for: .normal)
        images.shuffle()
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        rockButton.isEnabled = false

        yourChoice.text = "scissors"
        computerChoice.text = images[choosenImage]

        imageView.image = UIImage(named: images[choosenImage])
        
        self.resetTime()
        
        
        print(yScore, cScore)
        
        yourScore.text = String(yScore)
        computerScore.text = String(cScore)
        
        if yScore == 10 {
            alert(title: "Hurreeey", message: "You Won")
        }else if cScore == 10 {
            alert(title: "Ooooh!", message: "Computer Won!")
        }
    }

    
    
    func resetTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.yourChoice.text = "Your Choice"
            self.computerChoice.text = "Computer Choice"
            self.imageView.image = UIImage(named: "question")
            
            self.paperButton.isEnabled = true
            self.scissorsButton.isEnabled = true
            self.rockButton.isEnabled = true
            
        }
    }
    
    func gameRule(you: Choice, computer: Choice) {
        
        if you == computer {
            print("Even")
        }else if you == .rock && computer == .paper {
            yScore += 1
        }else if you == .rock && computer == .scissors {
            cScore += 1
        }else if you == .paper && computer == .rock {
            cScore += 1
        }else if you == .paper && computer == .scissors {
            yScore += 1
        }else if you == .scissors && computer == .paper {
            cScore += 1
        }else if you == .scissors && computer == .rock {
            yScore += 1
        }
        
      
    }
    
   @objc func alert(title: String, message: String) {
       
       guard let yourChoice = yourChoice.text else {
           print("no Share")
           return
       }
       
        let alertAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        let shareButton = UIAlertAction(title: "Share", style: .default) { UIAlertAction in
            let vc = UIActivityViewController(activityItems: [yourChoice], applicationActivities: [])
            
            vc.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            
            self.present(vc, animated: true, completion: nil)
        }
        alertAction.addAction(okButton)
        alertAction.addAction(shareButton)
        
        self.present(alertAction, animated: true, completion: nil)
    }
    
    
    
    enum Choice: String {
        case rock = "rock"
        case paper = "paper"
        case scissors = "scissors"

        
        static func randomComputerChoices() -> Choice {
            let choices: [Choice] = [.rock, .paper, .scissors]
            let index = Int(arc4random_uniform(UInt32(choices.count)))
            let choice = choices[index]
            return choice
        }
    }
    
   

}
