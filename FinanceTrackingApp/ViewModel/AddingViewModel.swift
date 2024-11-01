//
//  AddingViewModel.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 29.10.2024.
//

import UIKit

final class AddingViewModel {
    
    // probably will be better save each value in different variables whne typing is finished and after call the function createtransaction, it notifies user if some important field is empty, if field is optional to fill, it sends empty string
    
    let transactionType : TransactionType?
    
    init(transactionType: TransactionType) {
        self.transactionType = transactionType
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
}
