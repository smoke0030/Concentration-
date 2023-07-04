//
//  ViewController.swift
//  Concentration
//
//  Created by Сергей on 03.07.2023.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = ConcentrationGame(numberOfPairaOfCards: (buttonCollection.count + 1) / 2)
    private var touches = 0 {
        didSet {
            touchesLabel.text = "Touches: \(touches)"
        }
    }
    
    var emojiCollection = ["🦍","🦏","🦧","🐋","🐙","🐓","🦌","🐊","🐫","🐘","🦒","🦘"]
    var emojiDictionary = [Int: String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor(red: 0, green: 0, blue: 0, alpha: 0) : .blue
            }
        }
    }
    
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchesLabel: UILabel!
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
        
    }
    
}

