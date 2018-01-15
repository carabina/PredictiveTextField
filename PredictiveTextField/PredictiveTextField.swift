//
//  PredictiveTextField.swift
//  PredictiveSearch
//
//  Created by Daniel Fernandez on 1/15/18.
//  Copyright © 2018 Daniel Fernandez. All rights reserved.
//

import UIKit

public protocol PredictiveTextFieldDelegate: class{
  func predictiveTextFieldTextDidChange(_ predictiveTextField: PredictiveTextField, text: String)
  func predictiveTextFieldModelDidSelect(_ predictiveTextField: PredictiveTextField, model: Any)
}

public class PredictiveTextField: UIView{
  
  private lazy var textField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.borderStyle = .roundedRect
    tf.placeholder = "Empieza a escribir el nombre"
    tf.delegate = self
    tf.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    return tf
  }()
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.delegate = self
    tv.dataSource = self
    tv.separatorStyle = .none
    tv.register(PredictiveTextFieldCell.self, forCellReuseIdentifier: PredictiveTextFieldCell.identifier)
    tv.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    return tv
  }()
  
  var heightConstraint: NSLayoutConstraint!
  var models: [Any] = []
  var searchValues: [String] = []
  public weak var delegate: PredictiveTextFieldDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
    setupViews()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Error coder on PredictiveTextField")
  }
  
}

//MARK: Initial setup

extension PredictiveTextField{
  
  private func setupViews(){
    setupHeight()
    setupTextField()
    setupTableView()
  }
  
  private func setupHeight(){
    heightConstraint = heightAnchor.constraint(equalToConstant: ConstraintConstants.defaultHeight)
    heightConstraint.isActive = true
  }
  
  private func setupTextField(){
    addSubview(textField)
    textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
    textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    textField.heightAnchor.constraint(equalToConstant: ConstraintConstants.defaultHeight).isActive = true
  }
  
  private func setupTableView(){
    addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4).isActive = true
    tableView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
    tableView.heightAnchor.constraint(equalToConstant: ConstraintConstants.tableViewHeight).isActive = true
  }
  
}

//MARK: Handling methods

extension PredictiveTextField{
  
  @objc
  private func myTextFieldDidChange(){
    guard let text = textField.text else { return }
    if text.isEmpty{
      updateHeight(isSearching: false)
    }else{
      updateHeight(isSearching: true)
      delegate?.predictiveTextFieldTextDidChange(self, text: text)
    }
  }
  
}

//MARK: Internal methods

extension PredictiveTextField{
  
  public func updateSearchValues(models: [Any], valuesToShow: [String]){
    DispatchQueue.main.async {
      self.searchValues.removeAll()
      self.models = models
      self.searchValues = valuesToShow
      self.tableView.reloadData()
    }
  }
  
}

//MARK: Private methods

extension PredictiveTextField{
  
  func updateHeight(isSearching: Bool){
    if isSearching{
      heightConstraint.isActive = false
      heightConstraint.constant = ConstraintConstants.searchingHeight
      heightConstraint.isActive = true
    }else{
      heightConstraint.isActive = false
      heightConstraint.constant = ConstraintConstants.defaultHeight
      heightConstraint.isActive = true
    }
    
    updateLayout()
  }
  
  private func updateLayout(){
    UIView.animate(withDuration: 0.2) {
      self.layoutIfNeeded()
    }
  }
  
}

//MARK: UITextFieldDelegate

extension PredictiveTextField: UITextFieldDelegate{
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    updateHeight(isSearching: false)
  }
  
}

//MARK: UITableViewDelegate

extension PredictiveTextField: UITableViewDelegate{
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.predictiveTextFieldModelDidSelect(self, model: models[indexPath.row])
  }
  
}

//MARK: UITableViewDataSource

extension PredictiveTextField: UITableViewDataSource{
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchValues.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PredictiveTextFieldCell.identifier, for: indexPath) as! PredictiveTextFieldCell
    cell.valueLabel.text = searchValues[indexPath.row]
    return cell
  }
  
}

//MARK: Constants

extension PredictiveTextField{
  
  struct ConstraintConstants{
    static let defaultHeight: CGFloat = 44
    static let tableViewHeight: CGFloat = 150
    static let searchingHeight: CGFloat = ConstraintConstants.defaultHeight + ConstraintConstants.tableViewHeight
  }
  
}

