//
//  UserRegistrationViewController.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/07/01.
//

import UIKit
import RealmSwift

class UserRegistrationViewController: UIViewController {
    let colors = Colors()
    let user = UserModel()
    var inputData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        
        let contentView = UIView()
        contentView.frame.size = CGSize(width: view.frame.size.width, height: 440)
        contentView.center = CGPoint(x: view.center.x, y: view.center.y)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
        
        let titleLabel = UILabel()
        titleLabel.text = "ユーザー登録"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 140, width: view.frame.size.width, height: 100)
        view.addSubview(titleLabel)
        // 入力フォームとボタンを実装する。ボタンアクションはダイアログと登録処理の二つ
        
        let inputField = UITextField()
        inputField.placeholder = "登録するユーザー名を入力してください"
        inputField.textColor = .gray
        inputField.textAlignment = .center
        inputField.keyboardType = .default
        // これを設定するとtextFieldShouldReturnに入る様になる
        inputField.delegate = self
        inputField.frame = CGRect(x: 0, y: 320, width: view.frame.size.width, height: 200)
        view.addSubview(inputField)
        
        let registButton = UIButton(type: .system)
        registButton.setTitle("登録", for: .normal)
        registButton.frame = CGRect(x: 0, y: 520, width: 200, height: 40)
        registButton.center.x = view.center.x
        registButton.titleLabel?.font = .systemFont(ofSize: 20)
        registButton.setTitleColor(.white, for: .normal)
        registButton.backgroundColor = colors.orange
        registButton.addTarget(self, action: #selector(registAction), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(registButton)
        
        
    }
    
    @objc func registAction() {
        print("入力されたのは\(inputData)")
        // 入力された値をnameに設定する
        user.name = inputData
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
    }
}


extension UserRegistrationViewController: UITextFieldDelegate {
    //returnボタンが押された時にアクションする
    func textFieldShouldReturn(_ inputField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        inputData = inputField.text!
        return true
    }
}
