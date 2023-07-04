//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Сергей on 04.07.2023.
//

import Foundation

class ConcentrationGame {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairaOfCards: Int) {
        let allCards = createAllCards(numberOfPairs: numberOfPairaOfCards)
        cards = allCards.shuffled()
    }

    func createAllCards(numberOfPairs: Int) -> [Card] {
        var allCards = [Card]()
        
        for _ in 1...numberOfPairs {
            let card = Card()
            allCards.append(card)
            allCards.append(card)
        }
        
        return allCards
    }

}
