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
        
        cardView.layer.cornerRadius = PredefinedConstants.UI.cornerRadius
        cardView.layer.borderWidth = PredefinedConstants.UI.borderWidth
        contentView.addSubview(cardView)
        
        messageLabel.numberOfLines = 0
        messageLabel.textColor = PredefinedConstants.UI.primaryTextColor
        cardView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(PredefinedConstants.UI.messageViewMargin)
        }
    }

    func configure(with message: Message) {
        messageLabel.text = message.text
        if message.isUser {
            cardView.backgroundColor = PredefinedConstants.UI.cardViewBackgroundColor
            cardView.layer.borderColor = PredefinedConstants.UI.userMessageBorderColor
            cardView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(PredefinedConstants.UI.messageViewMargin)
                make.width.lessThanOrEqualToSuperview().multipliedBy(PredefinedConstants.UI.messageCellWidthMultiply)
                make.trailing.equalToSuperview().offset(-PredefinedConstants.UI.messageViewMargin)
            }
        } else {
            cardView.backgroundColor = PredefinedConstants.UI.cardViewBackgroundColor
            cardView.layer.borderColor = PredefinedConstants.UI.systemMessageBorderColor
            cardView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(PredefinedConstants.UI.messageViewMargin)
                make.width.lessThanOrEqualToSuperview().multipliedBy(PredefinedConstants.UI.messageCellWidthMultiply)
                make.leading.equalToSuperview().offset(PredefinedConstants.UI.messageViewMargin)
            }
        }
    }
}
