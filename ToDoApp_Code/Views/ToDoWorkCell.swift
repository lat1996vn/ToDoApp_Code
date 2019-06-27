//
//  toDoWorkCell.swift
//  ToDoApp
//
//  Created by TuanLA on 6/25/19.
//  Copyright © 2019 TuanLA. All rights reserved.
//

import UIKit

class ToDoWorkCell: UITableViewCell {

    let lblCreatedDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    let lblWorkTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 13)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    let btnCheckBoxIsDone: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_unchecked"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    let lblCompletedDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "System Medium", size: 14)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        
        self.addSubview(lblCreatedDate)
        
        NSLayoutConstraint.activate([
            lblCreatedDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            lblCreatedDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            lblCreatedDate.bottomAnchor.constraint(equalTo: lblCreatedDate.topAnchor, constant: 10)
            ])
        
        self.addSubview(lblWorkTitle)
        
        NSLayoutConstraint.activate([
            lblWorkTitle.leadingAnchor.constraint(equalTo: lblCreatedDate.leadingAnchor, constant: 0),
            lblWorkTitle.topAnchor.constraint(equalTo: lblCreatedDate.bottomAnchor, constant: 5)
            ])
        
        self.addSubview(btnCheckBoxIsDone)
        
        NSLayoutConstraint.activate([
            btnCheckBoxIsDone.widthAnchor.constraint(equalToConstant: 28),
            btnCheckBoxIsDone.heightAnchor.constraint(equalToConstant: 28),
            btnCheckBoxIsDone.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            btnCheckBoxIsDone.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        btnCheckBoxIsDone.addTarget(self, action: #selector(checkBoxIsDoneTapped), for: .touchUpInside)
    }
    
    @objc func checkBoxIsDoneTapped() {
        print("Tap")
    }
    
    func configCell(toDoWork: ToDoWork) {
        print("inCel")
        lblCreatedDate.text = toDoWork.createdDate
        lblWorkTitle.text = toDoWork.workTitle
        if toDoWork.isDone {
            btnCheckBoxIsDone.isHidden = true
            lblCompletedDate.isHidden = false
            lblCompletedDate.text = toDoWork.completedDate
        } else {
            btnCheckBoxIsDone.isHidden = false
            lblCompletedDate.isHidden = true
        }
    }
    
    func layoutToDoWorkCell() {

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutToDoWorkCell()
    }
    
    
}
