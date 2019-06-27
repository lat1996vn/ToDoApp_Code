//
//  ViewController.swift
//  ToDoApp_Code
//
//  Created by TuanLA on 6/27/19.
//  Copyright © 2019 TuanLA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let workListTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    } ()
    
    enum SectionType : Int{
        case Todo = 0
        case Complete
    }
    
    var todoList: [ToDoWork] = [ToDoWork(createDate: "23/03", workTitle: "test", workDetail: "test")]
    
    var completedList: [ToDoWork] = [ToDoWork(createDate: "23/03", workTitle: "test", workDetail: "test")]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SectionType.Todo.rawValue {
            return todoList.count
        } else {
            return completedList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoWorkCell {
            if(indexPath.section == SectionType.Todo.rawValue){
                print("toCel")
                cell.configCell(toDoWork: todoList[indexPath.row])
            } else {
                cell.configCell(toDoWork: completedList[indexPath.row])
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewIn = UIView(frame: .zero)
        let imgView = UIImageView(image: UIImage(named: "icon_list"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        viewIn.backgroundColor = .lightGray
        viewIn.borderWidth = 1
        viewIn.borderColor = .darkGray
        viewIn.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: viewIn.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: viewIn.leadingAnchor,constant: 8),
            imgView.topAnchor.constraint(equalTo: viewIn.topAnchor, constant: 8),
            imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: 3/4)
            ])
        
        let lblTitle = UILabel()
        if(section == SectionType.Todo.rawValue) {
            lblTitle.text = "List"
        }else{
            lblTitle.text = "Completed"
        }
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        viewIn.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.centerYAnchor.constraint(equalTo: viewIn.centerYAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: imgView.trailingAnchor,constant: 8),
            ])
        return viewIn
    }
    
    func layoutTableView() {
        view.addSubview(workListTableView)
        workListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            workListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            workListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            workListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workListTableView.register(ToDoWorkCell.self, forCellReuseIdentifier: "toDoCell")
        layoutTableView()
        workListTableView.delegate = self
        workListTableView.dataSource = self
    }


}

