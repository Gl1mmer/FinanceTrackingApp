//
//  ViewController.swift
//  FinanceTrackingApp
//
//  Created by Amankeldi Zhetkergen on 27.10.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainViewModel = MainViewModel()
    
    private let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let balanceTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "Balance"
        title.font = .systemFont(ofSize: 18, weight: .regular)
        title.textAlignment = .center
        title.textColor = .systemGray2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let balanceLabel: UILabel = {
        let title = UILabel()
        title.text = "$0"
        title.font = .systemFont(ofSize: 40, weight: .bold)
        title.textAlignment = .center
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let incomeLabel: UILabel = {
        let title = UILabel()
        title.text = "$0"
        title.font = .systemFont(ofSize: 30, weight: .regular)
        title.textAlignment = .left
        title.textColor = .systemGreen
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let expenseLabel: UILabel = {
        let title = UILabel()
        title.text = "$0"
        title.font = .systemFont(ofSize: 30, weight: .regular)
        title.textAlignment = .right
        title.textColor = .systemRed
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let recentTransactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let listView: UITableView = {
        let listView = UITableView()
        listView.backgroundColor = .systemGray6
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }()
    
    private lazy var addIncome: UIButton = {
        let button = UIButton()
        button.setTitle("Add Income", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTappedAddIncomeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addExpense: UIButton = {
        let button = UIButton()
        button.setTitle("Add Expense", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTappedAddExpenseButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        title = "Finance Tracker"
    }
    
    @objc func didTappedAddIncomeButton() {
        let addingVC = AddingViewController(transactionType: .income, categories: mainViewModel.getCategories(transactionType: .income))
        self.navigationItem.backButtonTitle = "Back"
        addingVC.delegate = self
        navigationController?.pushViewController(addingVC, animated: true)
    }
    
    @objc func didTappedAddExpenseButton() {
        let addingVC = AddingViewController(transactionType: .expense, categories: mainViewModel.getCategories(transactionType: .expense))
        self.navigationItem.backButtonTitle = "Back"
        addingVC.delegate = self
        navigationController?.pushViewController(addingVC, animated: true)
    }
}

//MARK: - TableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.getAllTransactions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListViewCell.identifier,
            for: indexPath
        ) as?  ListViewCell else {
            return UITableViewCell()
        }
        cell.configure(price: mainViewModel.getAllTransactions()[indexPath.row].price, transactionType: mainViewModel.getAllTransactions()[indexPath.row].type)
        return cell
    }
    
}
//MARK: - setup subviews
extension MainViewController {
    private func setupSubviews() {
        setupMainView()
        addSubviews()
        setupSubviewsConstraints()
        addSubviewsStyles()
    }
    
    private func setupMainView() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(infoView)
        infoView.addSubview(balanceTitleLabel)
        infoView.addSubview(balanceLabel)
        infoView.addSubview(incomeLabel)
        infoView.addSubview(expenseLabel)
        view.addSubview(recentTransactionLabel)
        view.addSubview(listView)
        view.addSubview(addIncome)
        view.addSubview(addExpense)
    }
    
    private func setupSubviewsConstraints() {
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 200),
            
            balanceTitleLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            balanceTitleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            
            balanceLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            balanceLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 5),
            
            incomeLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            incomeLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10),
            incomeLabel.trailingAnchor.constraint(equalTo: infoView.centerXAnchor, constant: -10),
            incomeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            expenseLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            expenseLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10),
            expenseLabel.leadingAnchor.constraint(equalTo: infoView.centerXAnchor, constant: 10),
            expenseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            recentTransactionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recentTransactionLabel.bottomAnchor.constraint(equalTo: listView.topAnchor, constant: -10),
            recentTransactionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 50),
            listView.heightAnchor.constraint(equalToConstant: 360),
            
            addIncome.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            addIncome.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            addIncome.heightAnchor.constraint(equalToConstant: 60),
            addIncome.widthAnchor.constraint(equalToConstant: 150),
            
            addExpense.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            addExpense.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            addExpense.heightAnchor.constraint(equalToConstant: 60),
            addExpense.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func addSubviewsStyles() {
        listView.dataSource = self
        listView.delegate = self
        listView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.identifier)
    }
}

extension MainViewController: AddingViewControllerDelegate {
    func didInsertButtonTapped(_ transaction: TransactionModel) {
        mainViewModel.addNewTransaction(transaction)
        updateUI()
    }
    
    func updateUI() { // not delegate function
        listView.reloadData()
        balanceLabel.text = "$\(mainViewModel.getBalance())"
        incomeLabel.text = "$\(mainViewModel.getIncome())"
        expenseLabel.text = "$\(mainViewModel.getExpense())"
    }
}

