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
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(cardView)
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 14)
        questionLabel.textColor = .white
        cardView.addSubview(questionLabel)
        
        questionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        }
    }
    
    // MARK: - Configuration
    
    func configure(with question: String) {
        questionLabel.text = question
    }
}
