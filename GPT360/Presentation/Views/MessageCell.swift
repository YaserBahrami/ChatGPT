//
//  MessageCell.swift
//  GPT360
//
//  Created by Yaser on 14.06.2024.
//
import UIKit
import SnapKit

class MessageCell: UITableViewCell {
    private let messageLabel = UILabel()
    private let cardView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 8
        cardView.layer.borderWidth = 1
        contentView.addSubview(cardView)
        
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .white
        cardView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    func configure(with message: Message) {
        messageLabel.text = message.text
        if message.isUser {
            cardView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            cardView.layer.borderColor = UIColor.blue.cgColor
            cardView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
                make.trailing.equalToSuperview().offset(-8)
            }
        } else {
            cardView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
            cardView.layer.borderColor = UIColor.white.cgColor
            cardView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
                make.leading.equalToSuperview().offset(8)
            }
        }
    }
}
