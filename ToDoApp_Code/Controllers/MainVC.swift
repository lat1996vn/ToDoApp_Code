//
//  ViewController.swift
//  ToDoApp_Code
//
//  Created by TuanLA on 6/27/19.
//  Copyright © 2019 TuanLA. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // MARK: - Variables
    let workListTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    } ()
    
    let btnAddItem: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
        return button
    } ()
    
    enum SectionType : Int{
        case Todo = 0
        case Complete
    }
    
    var todoList: [ToDoWork] = [ToDoWork(createDate: "23/03", workTitle: "test", workDetail: "test")]
    
    var completedList: [ToDoWork] = [ToDoWork(createDate: "23/03", workTitle: "test", workDetail: "test")]
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        workListTableView.register(ToDoWorkCell.self, forCellReuseIdentifier: "toDoCell")
        layoutTableView()
        workListTableView.delegate = self
        workListTableView.dataSource = self
    }
    
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
            cell.delegate = self
            var toDoItem: ToDoWork!
            if(indexPath.section == SectionType.Todo.rawValue){
                print("toCel")
                toDoItem = self.todoList[indexPath.row]
            } else {
                toDoItem = self.completedList[indexPath.row]
            }
            cell.configCell(toDoWork: toDoItem)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var itemWorkScreentype: ItemWorkVC.ItemWorkScreentype!
        if indexPath.section == SectionType.Todo.rawValue {
            itemWorkScreentype = .Edit
        } else {
            itemWorkScreentype = .View
        }
        let vc = ItemWorkVC(nibName: nil, bundle: nil,screenType: itemWorkScreentype)
        vc.itemWork = todoList[indexPath.row]
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            if indexPath.section == SectionType.Todo.rawValue {
                self.todoList.remove(at: indexPath.row)
                tableView.reloadData()
                //tableView.endUpdates()
            } else {
                self.completedList.remove(at: indexPath.row)
                tableView.reloadData()
                //tableView.endUpdates()
            }
        }
        let compelete = UIContextualAction(style: .normal, title: "Complete") { (action, view, nil) in
            
                self.completedList.insert(self.todoList[indexPath.row], at: 0)
                self.todoList.remove(at: indexPath.row)
                tableView.reloadData()
        }
        compelete.backgroundColor = #colorLiteral(red: 0.2142799043, green: 0.6263519211, blue: 0.9060877955, alpha: 1)
        
        if indexPath.section == SectionType.Todo.rawValue {
            return UISwipeActionsConfiguration(actions: [delete,compelete])
        } else {
            return UISwipeActionsConfiguration(actions: [delete])
        }
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
        self.title = "ToDo List"
        
        let barBuntonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_plus"), style: .plain, target: self, action: #selector(self.popToAddItem))
        barBuntonItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = barBuntonItem
        
        view.addSubview(workListTableView)
        workListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            workListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            workListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            workListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    @objc func popToAddItem() {
        let vc = ItemWorkVC(nibName: nil, bundle: nil, screenType: ItemWorkVC.ItemWorkScreentype.Add)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension MainVC: ToDoWorkCellDelegate, ItemWorkVCDelegate {
    func addItemWork(work: ToDoWork) {
        self.todoList.insert(work, at: 0)
        self.workListTableView.reloadData()
    }
    
    func saveItemWork() {
        print("save")
        self.workListTableView.reloadData()
    }
    
    func tapCompleted() {
        print("tap")
    }
}
