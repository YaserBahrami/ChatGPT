//
//  PredefinedConstants.swift
//  GPT360
//
//  Created by Yaser on 14.06.2024.
//

import Foundation
import UIKit

struct PredefinedConstants {
    
    static let sampleQuestions = [
        "Tell me about 1453 in Turkish culture",
        "What's AI?",
        "Tell me a joke",
        "How's the weather",
        "Recommend a movie",
        "How to cook pasta?",
        "What is Swift programming language",
        "Define gravity",
        "Teach me greeting in Turkish language",
        "List me 5 places I must visit in Turkey"
    ]
    
    struct UI {
        static let collectionViewCellWidthMultiply = 0.8
        static let messageCellWidthMultiply = 0.8
        static let collectionViewCellHeight = 100
        static let collectionViewCellSpace = 10.0
        static let chatBoxHeight = 36
        static let chatBoxMargin = 16
        static let topBottomMargin = 8
        static let messageViewMargin = 8
        static let questionCardViewMargin: CGFloat = 8.0
        static let questionCardViewSideMargin: CGFloat = 16.0
        
        
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 1.0
        static let userMessageBorderColor: CGColor = UIColor.blue.cgColor
        static let systemMessageBorderColor: CGColor = UIColor.gray.cgColor
        static let cardViewBackgroundColor: UIColor = UIColor.gray.withAlphaComponent(0.1)
        static let suggestionViewBackgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.1)
        
        static let messageTextColor: UIColor = .white
        
    }
    
    struct Text {
        static let navigationTitle = "Chat GPT"
        static let SuggestionLabel = "Questions you can ask..."
    }
    
    struct Fonts {
        static let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let suggestionLabelFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    struct Cells {
        static let questionCellId = "questionCell"
        static let messageCellId = "messageCell"
    }
    
    struct Images {
        static let sendButtonImage = UIImage(named: "icon_send")
        static let loadingButtonImage = UIImage(named: "icon_loading")
        static let deleteButtonImage = UIImage(named: "icon_delete")
        static let backgroundImage = UIImage(named: "Background")
    }
}
