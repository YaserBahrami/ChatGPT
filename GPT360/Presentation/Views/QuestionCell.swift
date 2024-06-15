//
//  QuestionCell.swift
//  GPT360
//
//  Created by Yaser on 14.06.2024.
//

import UIKit
import SnapKit
import UIKit
import SnapKit

class QuestionCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let questionLabel = UILabel()
    private let cardView = UIView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        cardView.layer.cornerRadius = PredefinedConstants.UI.cornerRadius
        cardView.backgroundColor = PredefinedConstants.UI.suggestionViewBackgroundColor
        contentView.addSubview(cardView)
        
        let margin = PredefinedConstants.UI.questionCardViewMargin
        let sideMargin = PredefinedConstants.UI.questionCardViewSideMargin
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: margin, left: sideMargin, bottom: margin, right: sideMargin))
        }
        
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.font = PredefinedConstants.Fonts.suggestionLabelFont
        questionLabel.textColor = .white
        cardView.addSubview(questionLabel)
        
        questionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        }
    }
    
    // MARK: - Configuration
    
    func configure(with question: String) {
        questionLabel.text = question
    }
}
