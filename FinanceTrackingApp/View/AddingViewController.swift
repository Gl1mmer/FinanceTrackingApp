//
//  AddingViewController.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 29.10.2024.
//

import UIKit

protocol AddingViewControllerDelegate: AnyObject {
    func didInsertButtonTapped(_ transaction: TransactionModel)
}

final class AddingViewController: UIViewController, UITextFieldDelegate {
    
    let addingViewModel : AddingViewModel
    
    var delegate : AddingViewControllerDelegate?
    
    private let enterPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a price:"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "$0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
//        textField.borderStyle = .roundedRect
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 50, weight: .bold)
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Write a category"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write a description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var insertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Insert", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        button.addTarget(self, action: #selector(insertTransaction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(transactionType: TransactionType) {
        addingViewModel = AddingViewModel(transactionType: transactionType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupOpeningScreen(transactionType: addingViewModel.transactionType!)
    }
    
    func setupOpeningScreen(transactionType: TransactionType) {
        switch transactionType {
        case .income:
            view.backgroundColor = .systemGreen
            title = "Income"
        case .expense:
            view.backgroundColor = .systemRed
            title = "Expense"
        }
    }

    @objc private func insertTransaction() {
        let transaction = addingViewModel.createTransaction(
            price: Int(priceTextField.text ?? "0") ?? 0,
            title: titleTextField.text ?? "",
            description: descriptionTextField.text ?? "",
            category: categoryTextField.text ?? "")

        delegate?.didInsertButtonTapped(transaction)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - setup subviews
extension AddingViewController {
    private func setupSubviews() {
        setupMainView()
        addSubviews()
        setupSubviewsConstraints()
        addSubviewsStyles()
    }
    
    private func setupMainView() {
        view.backgroundColor = .systemBlue // if any error
    }
    
    private func addSubviews() {
        view.addSubview(enterPriceLabel)
        view.addSubview(priceTextField)
        view.addSubview(descriptionView)
        descriptionView.addSubview(categoryTextField)
        descriptionView.addSubview(titleTextField)
        descriptionView.addSubview(descriptionTextField)
        descriptionView.addSubview(insertButton)
    }
    
    private func setupSubviewsConstraints() {
        NSLayoutConstraint.activate([
            enterPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            enterPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            enterPriceLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            //            enterPriceLabel.heightAnchor.constraint(equalToConstant: 50),
            
            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            priceTextField.topAnchor.constraint(equalTo: enterPriceLabel.bottomAnchor, constant: 5),
            priceTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            //            priceTextField.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionView.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 30),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoryTextField.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 45),
            categoryTextField.heightAnchor.constraint(equalToConstant: 60),
            
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            titleTextField.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 45),
            titleTextField.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 45),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 60),
            
            insertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            insertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            insertButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            insertButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func addSubviewsStyles() {
    }
}
