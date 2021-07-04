//
//  ViewController.swift
//  CoronaInformationInJapan
//
//  Created by Shunsuke_MIYANO on 2021/06/05.
//

import UIKit

class ViewController: UIViewController {
    // インスタンス化
    let colors = Colors()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpGradation()
        // UIView: デバイス画面上の描画やイベント受信をつかさどる部品で、デバイス画面に配置するすべての部品はUIViewを継承している。
        let contentView = UIView()
        contentView.frame.size = CGSize(width: view.frame.size.width, height: 340)
        contentView.center = CGPoint(x: view.center.x, y: view.center.y)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
        
        view.backgroundColor = .systemGray6
        // テキスト部分実装
        let labelFont = UIFont.systemFont(ofSize: 15, weight: .heavy)
        let size = CGSize(width: 150, height: 50)
        let color = colors.red
        let leftX = view.frame.size.width * 0.33
        let rightX = view.frame.size.width * 0.80
        setUpLabel("Covid in Japan", size: CGSize(width: 150, height: 50), centerX: view.frame.size.width * 0.33, y: -60, font: .systemFont(ofSize: 20, weight: .heavy), color: .white, contentView)
        setUpLabel("PCR数", size: size, centerX: leftX, y: 20, font: labelFont, color: color, contentView)
        setUpLabel("感染者数", size: size, centerX: rightX, y: 20, font: labelFont, color: color, contentView)
        setUpLabel("入院者数", size: size, centerX: leftX, y: 120, font: labelFont, color: color, contentView)
        setUpLabel("重症者数", size: size, centerX: rightX, y: 120, font: labelFont, color: color, contentView)
        setUpLabel("死者数", size: size, centerX: leftX, y: 220, font: labelFont, color: color, contentView)
        setUpLabel("退院者数", size: size, centerX: rightX, y: 220, font: labelFont, color: color, contentView)
        
        // ボタン実装
        let height = view.frame.size.height / 2
        /*
         touchDown: 下から出てくる
         */
        setUpButton("健康状態", size: size, y: height + 190, color: colors.red, parentView: view).addTarget(self, action: #selector(goHealthCheck), for: .touchDown)
        setUpButton("県別状態", size: size, y: height + 240, color: colors.red, parentView: view)
        
        setUpButton("ユーザー登録", size: size, y: height + 290, color: colors.red, parentView: view).addTarget(self, action: #selector(goUserRegistration), for: .touchDown)
        // 画面上部のボタン
        // #selectorで@objcを呼び出す。タップアクション的な
        // ただボタンを押下しても何も起きない。うまく継承できていないかも
        setUpImageButton("chatIcon", x: view.frame.size.width - 50).addTarget(self, action: #selector(chatAction), for: .touchDown)
        setUpImageButton("reload", x: 13).addTarget(self, action: #selector(reloadAction), for: .touchDown)
        // TODO: 下記のソース解析を行う
        let imageView = UIImageView()
        let image = UIImage(named: "virus")
        imageView.image = image
        imageView.frame = CGRect(x: view.frame.size.width, y: -65, width: 50, height: 50)
        contentView.addSubview(imageView)
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.curveEaseIn], animations: {imageView.frame = CGRect(x: self.view.frame.size.width - 100, y: -65, width: 50, height: 50)
            imageView.transform = CGAffineTransform(rotationAngle: -90)
        }, completion: nil)
        
        setUpAPI(parentView: contentView)
    }
    
    func setUpAPI(parentView: UIView) {
        let pcr = UILabel()
        let positive = UILabel()
        let hospitalize = UILabel()
        let severe = UILabel()
        let death = UILabel()
        let discharge = UILabel()
        
        let size = CGSize(width: 200, height: 40)
        let leftX = view.frame.size.width * 0.38
        let rightX = view.frame.size.width * 0.85
        let font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        let color = colors.red
        
        setUpAPILabel(pcr, size: size, centerX: leftX, y: 60, font: font, color: color, parentView)
        setUpAPILabel(positive, size: size, centerX: rightX, y: 60, font: font, color: color, parentView)
        setUpAPILabel(hospitalize, size: size, centerX: leftX, y: 160, font: font, color: color, parentView)
        setUpAPILabel(severe, size: size, centerX: rightX, y: 160, font: font, color: color, parentView)
        setUpAPILabel(death, size: size, centerX: leftX, y: 260, font: font, color: color, parentView)
        setUpAPILabel(discharge, size: size, centerX: rightX, y: 260, font: font, color: color, parentView)
        
        CovidAPI.getTotal(completion: {(result: CoviInfo.Total) -> Void in
            DispatchQueue.main.async {
                pcr.text = "\(result.pcr)"
                positive.text = "\(result.positive)"
                hospitalize.text = "\(result.hospitalize)"
                severe.text = "\(result.severe)"
                death.text = "\(result.death)"
                discharge.text = "\(result.discharge)"
                
            }
            
        })
        
    }
    
    func setUpGradation() {
        // CAGradientLayer: 背景色の上に色のグラデーションを描画し、レイヤーの形状を塗りつぶすレイヤー (角の丸みを含む)
        let gradientLayer = CAGradientLayer()
        // CGRect: 長方形の位置と寸法を含む構造。多分範囲を決める時に使う
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
        // cgColor: 色を定義するコンポーネントのセット
        gradientLayer.colors = [colors.orange.cgColor, colors.red.cgColor]
        // CGPoint: 2次元座標系の点を含む構造。多分これも範囲的なものを決める時に使う
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        // insertSublayer: レイヤーに挿入する時に使用する
        view.layer.insertSublayer(gradientLayer, at:0)
        
        // TODO: もっと細かくソース解析を行う
    }
    
    func setUpAPILabel(_ label: UILabel, size: CGSize, centerX: CGFloat, y: CGFloat, font: UIFont, color: UIColor, _ parentView: UIView) {
        label.frame.size = size
        label.center.x = centerX
        label.frame.origin.y = y
        label.font = font
        label.textColor = color
        parentView.addSubview(label)
    }
    
    func setUpLabel(_ text: String, size: CGSize, centerX: CGFloat, y: CGFloat, font: UIFont, color: UIColor, _ parentView: UIView) {
        let label = UILabel()
        label.text = text
        label.frame.size = size
        label.center.x = centerX
        label.frame.origin.y = y
        label.font = font
        label.textColor = color
        // ここでviewをセットしている
        parentView.addSubview(label)
        
    }
    // 返す変数の方を「 -> 型名」で書く
    func setUpButton(_ title: String, size: CGSize, y: CGFloat, color: UIColor, parentView: UIView) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.frame.size = size
        button.center.x = view.center.x
        // NSAttributedString: テキストの一部に関連付けられた属性 (視覚スタイル、ハイパーリンク、アクセシビリティ データなど) を持つ文字列。
        // kern: カーニングは、特定の文字の間に不要なスペースが発生するのを防ぎ、フォントに依存します。恐らく字の間隔を設定して固定するときに使う
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.kern: 8.0])
        // .normal: コントロール可能な状態を設定するときに使う
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.frame.origin.y = y
        button.setTitleColor(color, for: .normal)
        // ここでviewをセットしている
        parentView.addSubview(button)
        
        return button
    }
    
    func setUpImageButton(_ name: String, x: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: name), for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        button.tintColor = .white
        button.frame.origin = CGPoint(x: x, y: 25)
        view.addSubview(button)
        return button
    }
    
    @objc func chatAction() {
        print("タップchat")
    }
    
    @objc func reloadAction() {
        loadView()
        viewDidLoad()
    }
    
    @objc func goHealthCheck() {
        /*
         performSegue: segueを使用して画面遷移したいときに使用する。
         withIdentifierにはsegueのidentifierに設定した値
         senderには遷移時に何かを受け渡したいときに設定する(なければnilを渡す)
         
         */
        performSegue(withIdentifier: "goHealthCheck", sender: nil)
    }
    
    @objc func goUserRegistration() {
        performSegue(withIdentifier: "goUserRegistration", sender: nil)
    }


}

