//
//  PredictiveTextFieldCell.swift
//  PredictiveSearch
//
//  Created by Daniel Fernandez on 1/15/18.
//  Copyright © 2018 Daniel Fernandez. All rights reserved.
//

import UIKit

class PredictiveTextFieldCell: UITableViewCell{
  
  static let identifier = "PredictiveTextFieldCell"
  
  let valueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .darkGray
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Error coder on PredictiveTextFieldCell")
  }
  
  private func setupCell(){
    selectionStyle = .none
    backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
  }
  
  private func setupViews(){
    addSubview(valueLabel)
    valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
}

