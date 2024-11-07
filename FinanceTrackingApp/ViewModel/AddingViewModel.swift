//
//  AddingViewModel.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 29.10.2024.
//

import UIKit

final class AddingViewModel {

    
    private let transactionType : TransactionType?
    
    private let categories: [String]?
    
    init(transactionType: TransactionType, categories: [String]) {
        self.transactionType = transactionType
        self.categories = categories
    }
    
    func createTransaction(
        price: Int,
        title: String,
        description: String,
        category: String
    ) -> TransactionModel {
        let transaction = TransactionModel(
                type: transactionType ?? .income ,
                price: price,
                title: title,
                description: description,
                category: category)
        return transaction
    }
    
    func getCategories() -> [String] {
        categories ?? []
    }
    
    func getTransactionType() -> TransactionType? {
        transactionType
    }
}
