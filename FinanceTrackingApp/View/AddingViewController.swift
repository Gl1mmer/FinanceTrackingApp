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
        textField.placeholder = "Select a category"
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let categoryMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down.square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    init(transactionType: TransactionType, categories: [String]) {
        addingViewModel = AddingViewModel(transactionType: transactionType, categories: categories)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupOpeningScreen(transactionType: addingViewModel.getTransactionType()!)
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
        setupCategoryMenu()
    }
    
    private func setupMainView() {
        view.backgroundColor = .systemYellow // if any error
    }
    
    private func addSubviews() {
        view.addSubview(enterPriceLabel)
        view.addSubview(priceTextField)
        view.addSubview(descriptionView)
        descriptionView.addSubview(categoryTextField)
        descriptionView.addSubview(categoryMenuButton)
        descriptionView.addSubview(titleTextField)
        descriptionView.addSubview(descriptionTextField)
        descriptionView.addSubview(insertButton)
    }
    
    private func setupSubviewsConstraints() {
        NSLayoutConstraint.activate([
            enterPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            enterPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            enterPriceLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor),

            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            priceTextField.topAnchor.constraint(equalTo: enterPriceLabel.bottomAnchor, constant: 5),
            priceTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor),

            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionView.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 30),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoryTextField.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 45),
            categoryTextField.heightAnchor.constraint(equalToConstant: 60),
            
            categoryMenuButton.widthAnchor.constraint(equalToConstant: 60),
            categoryMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoryMenuButton.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 45),
            categoryMenuButton.heightAnchor.constraint(equalToConstant: 60),
            
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
    
    private func setupCategoryMenu() {
        var actions: [UIAction] = []
        for category in addingViewModel.getCategories() {
            let action = UIAction(title: category) { _ in
                self.categoryTextField.text = category
            }
            actions.append(action)
        }
        
        let categoryMenu = UIMenu(title: "Select a category", children: actions)
        
        categoryMenuButton.menu = categoryMenu
        categoryMenuButton.showsMenuAsPrimaryAction = true
    }
}
