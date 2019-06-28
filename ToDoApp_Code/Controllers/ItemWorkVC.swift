//
//  AddItemVC.swift
//  ToDoApp
//
//  Created by TuanLA on 6/26/19.
//  Copyright © 2019 TuanLA. All rights reserved.
//

import UIKit

protocol ItemWorkVCDelegate: AnyObject {
    func saveItemWork()
    func addItemWork(work: ToDoWork)
}

class ItemWorkVC: UIViewController {
    enum ItemWorkScreentype: String {
        case Add = "ADD"
        case Edit = "SAVE"
        case View = ""
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, screenType: ItemWorkScreentype) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(screenType.rawValue)
        self.screenType = screenType
        if screenType != .View{
            btnSave.setTitle(screenType.rawValue, for: .normal)
        } else {
            btnSave.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ItemWorkVCDelegate?
    var itemWork: ToDoWork? {
        didSet {
            guard let item = itemWork else {return}
            self.loadUIData(item: item)
        }
    }
    
    var screenType: ItemWorkScreentype!
    
    let lblWorkTitle: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont(name: "System", size: 14.0)
        lable.text = "Work title"
        return lable
    } ()
    
    let lblWorkDetail: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont(name: "System", size: 14.0)
        lable.text = "Work Detail"
        return lable
    } ()
    
    let tfWorkTitle: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.cornerRadius = 8
        textField.backgroundColor = .lightGray
        textField.autocorrectionType = .no
        return textField
    } ()
    
    let tvWorkDetail: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.cornerRadius = 8
        textView.backgroundColor = .lightGray
        textView.autocorrectionType = .no
        return textView
    } ()
    
    let btnSave: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    var toDoWork: ToDoWork?
    
    @objc func btnAddTapped() {
        //delegate?.saveItemWork()
        if let _ = toDoWork {
        } else {
            let work = ToDoWork(createDate: getCurrentDate(), workTitle: tfWorkTitle.text!, workDetail: tvWorkDetail.text)
            delegate?.addItemWork(work: work)
//            work.workTitle = tfWorkTitle.text!
//            work.workDetail = tvWorkDetail.text
//            work.createdDate = getCurrentDate()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSaveTapped() {

        guard let item = itemWork else {return}
        item.workTitle = tfWorkTitle.text!
        item.workDetail = tvWorkDetail.text!
        delegate?.saveItemWork()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addActionToButtonSave()
        // Do any additional setup after loading the view.
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        let workTilteStackView = UIStackView(arrangedSubviews: [lblWorkTitle, tfWorkTitle])
        workTilteStackView.axis = .vertical
        workTilteStackView.alignment = .fill
        workTilteStackView.distribution = .fill
        workTilteStackView.translatesAutoresizingMaskIntoConstraints = false
        workTilteStackView.spacing = 10
        NSLayoutConstraint.activate([tfWorkTitle.heightAnchor.constraint(equalTo: workTilteStackView.heightAnchor, multiplier: 0.6)])
        
        let workDetailStackView = UIStackView(arrangedSubviews: [lblWorkDetail, tvWorkDetail])
        workDetailStackView.axis = .vertical
        workDetailStackView.alignment = .fill
        workDetailStackView.distribution = .fill
        workDetailStackView.spacing = 10
        workDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(workTilteStackView)
        
        NSLayoutConstraint.activate([
            workTilteStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workTilteStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            workTilteStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            workTilteStackView.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        view.addSubview(workDetailStackView)

        NSLayoutConstraint.activate([
            workDetailStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workDetailStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            workDetailStackView.topAnchor.constraint(equalTo: workTilteStackView.bottomAnchor, constant: 30),
            workDetailStackView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        view.addSubview(btnSave)
            NSLayoutConstraint.activate([
            btnSave.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnSave.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            btnSave.widthAnchor.constraint(equalToConstant: 280),
            btnSave.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func addActionToButtonSave() {
        if let type = screenType {
            switch type {
            case .Add:
                btnSave.addTarget(self, action: #selector(btnAddTapped), for: .touchUpInside)
            case .Edit:
                btnSave.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
            default:
                break
            }
        }
    }
    
    func loadUIData(item: ToDoWork) {
        tfWorkTitle.text = item.workTitle
        tvWorkDetail.text = item.workDetail
//        if screenType != .View{
//            btnSave.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
//        } else {
//            btnSave.isHidden = true
//        }
    }
    
}
