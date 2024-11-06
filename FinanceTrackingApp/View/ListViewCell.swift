//
//  listViewCell.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 29.10.2024.
//

import UIKit

class ListViewCell: UITableViewCell {
    // based on the category, we set the avatar
    
    static let identifier = String(describing: ListViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(price: Int, transactionType: TransactionType) {
        titleLabel.text = String(price)
        if transactionType == .expense {
            titleLabel.textColor = .systemRed
        } else {
            titleLabel.textColor = .systemGreen
        }
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        backgroundColor = .systemGray6
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    
}
