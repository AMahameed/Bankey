//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 8/18/22.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
    case Banking
    case CreditCard
    case Investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString {
                return CurrencyFormatter().makeAttributedCurrency(balance)
            }
    }
    
    let viewModel: ViewModel? = nil
    let typeLabel = UILabel()
    let divider = UIView()
    let nameLabel = UILabel()
    let stackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell{
    func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Account type"
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = appColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Account name"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.text = "Some Balance"
        balanceLabel.textAlignment = .right
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "xxx,xxx", cents: "xx")
        balanceAmountLabel.textAlignment = .right
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevron = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevron
        
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(divider)
        contentView.addSubview(nameLabel)
        stackView.addArrangedSubview(balanceLabel)
        stackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(chevronImageView)
        
    }
    
    func layout() {
        
//        Type label
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
//        Divider
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 4),
            divider.widthAnchor.constraint(equalToConstant: 60),
            divider.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            divider.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
//        Type label
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
//        StackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 4)
        ])
        
//        Chevron image view
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
            let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
            let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
            let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
            
            let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
            let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
            let centString = NSAttributedString(string: cents, attributes: centAttributes)
            
            rootString.append(dollarString)
            rootString.append(centString)
            
            return rootString
        }
}

extension AccountSummaryCell{
    func configure(with account: ViewModel){
        
        typeLabel.text = account.accountType.rawValue
        nameLabel.text = account.accountName
        balanceAmountLabel.attributedText = account.balanceAsAttributedString
        
        switch account.accountType {
        case .Banking:
            divider.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            divider.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            divider.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
