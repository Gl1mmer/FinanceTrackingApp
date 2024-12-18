//
//  MainViewModel.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 29.10.2024.
//
import UIKit

final class MainViewModel {
    
    private var balance = 0
    private var income = 0
    private var expense = 0
    
    private var allTransactions: [TransactionModel] = []
    
    private let expenseCategories = [
        "shopping",
        "food",
        "transport",
        "entertainment",
        "other"
    ]
    
    private let incomeCategories = [
        "salary",
        "bonus",
        "stipend",
        "other"
    ]
    
    func addNewTransaction(_ transaction: TransactionModel) {
        switch transaction.type {
            case .income:
            income += transaction.price
            case .expense:
            expense += transaction.price
        }
        balance = income - expense
        allTransactions.append(transaction)
    }
    
    func getAllTransactions() -> [TransactionModel] {
        return allTransactions
    }
    
    func getBalance() -> String {
        return String(balance)
    }
    
    func getIncome() -> String {
        return String(income)
    }
    
    func getExpense() -> String {
        return String(expense)
    }
    
    func getCategories(transactionType: TransactionType) -> [String] {
        switch transactionType {
            case .expense:
                return expenseCategories
            case .income:
                return incomeCategories
        }
    }
    
}
