//
//  TransactionModel.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 29.10.2024.
//

import UIKit

enum TransactionType {
    case income
    case expense
}

struct TransactionModel {
    let type: TransactionType
    let price: Int
    let title: String
    let description: String
    let category: String
}

