//
//  CircleChartViewController.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/07/05.
//
import UIKit
import Charts

class CircleChartViewController: UIViewController {
    
    let colors = Colors()
    var prefecture = UILabel()
    var pcr = UILabel()
    var pcrCount = UILabel()
    var cases = UILabel()
    var casesCount = UILabel()
    var deaths = UILabel()
    var deathsCount = UILabel()
    var segment = UISegmentedControl()
    var array:[CovidInfo.Prefecture] = []
    
    var pattern = "cases"
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        gradientLayer.colors = [colors.orange.cgColor, colors.red.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 10, y: 30, width: 20, height: 20)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(buckButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
        
        let nextButton = UIButton(type: .system)
        nextButton.frame = CGRect(x: view.frame.size.width - 105, y: 25, width: 100, height: 30)
        nextButton.setTitle("円グラフ", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20)
        nextButton.addTarget(self, action: #selector(goCircle), for: .touchUpInside)
        
        segment = UISegmentedControl(items: ["感染者数", "PCR数", "死者数"])
        segment.frame = CGRect(x: 10, y: 70, width: view.frame.size.width - 20, height: 20)
        segment.selectedSegmentTintColor = colors.orange
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: colors.orange], for: .normal)
        segment.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        view.addSubview(segment)
        
        searchBar.frame = CGRect(x: 10, y: 100, width: view.frame.size.width - 20, height: 20)
        searchBar.delegate = self
        searchBar.placeholder = "都道府県を漢字で入力"
        searchBar.showsCancelButton = true
        searchBar.tintColor = colors.orange
        view.addSubview(searchBar)
        
        let uiView = UIView()
        uiView.frame = CGRect(x: 10, y: 480, width: view.frame.size.width - 20, height: 167)
        uiView.layer.cornerRadius = 10
        uiView.backgroundColor = .white
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowOpacity = 0.4
        uiView.layer.shadowRadius = 10
        view.addSubview(uiView)
        
        bottomLabel(uiView, prefecture, 1, 10, text: "東京", size: 30, weight: .ultraLight, color: UIColor.black)
        bottomLabel(uiView, pcr, 0.39, 50, text: "PCR数", size: 15, weight: .bold, color: colors.red)
        bottomLabel(uiView, pcrCount, 0.39, 85, text: "2222222", size: 30, weight: .bold, color: colors.orange)
        bottomLabel(uiView, cases, 1, 50, text: "感染者数", size: 15, weight: .bold, color: colors.red)
        bottomLabel(uiView, casesCount, 1, 85, text: "22222", size: 30, weight: .bold, color: colors.orange)
        bottomLabel(uiView, deaths, 1.61, 50, text: "死者数", size: 15, weight: .bold, color: colors.red)
        bottomLabel(uiView, deathsCount, 1.61, 85, text: "2222", size: 30, weight: .bold, color: colors.orange)
        
        view.backgroundColor = .systemGroupedBackground
        
        for i in 0..<CovidSingleton.shared.prefecture.count {
            if CovidSingleton.shared.prefecture[i].name_ja == "東京" {
                prefecture.text = CovidSingleton.shared.prefecture[i].name_ja
                pcrCount.text = "\(CovidSingleton.shared.prefecture[i].pcr)"
                casesCount.text = "\(CovidSingleton.shared.prefecture[i].cases)"
                deathsCount.text = "\(CovidSingleton.shared.prefecture[i].deaths)"
            }
        }
        
        
        array = CovidSingleton.shared.prefecture
        array.sort(by: {
            a, b -> Bool in
            if pattern == "pcr" {
                return a.pcr > b.pcr
            } else if pattern == "deaths" {
                return a.deaths > b.deaths
            } else {
                return a.cases > b.cases
            }
        })
        dataSet()
        
    }
    
    func dataSet() {
        var entrys:[PieChartDataEntry] = []
        if pattern == "cases" {
            for i in 0...4 {
                segment.selectedSegmentIndex = 0
                entrys += [PieChartDataEntry(value: Double(array[i].cases), label: array[i].name_ja)]
            }
        } else if pattern == "pcr" {
            for i in 0...4 {
                segment.selectedSegmentIndex = 1
                entrys += [PieChartDataEntry(value: Double(array[i].pcr), label: array[i].name_ja)]
            }
        } else if pattern == "deaths" {
            for i in 0...4 {
                segment.selectedSegmentIndex = 2
                entrys += [PieChartDataEntry(value: Double(array[i].deaths), label: array[i].name_ja)]
            }
        }
        
        let circleView = PieChartView(frame: CGRect(x: 0, y: 150, width: view.frame.size.width, height: 300))
        circleView.centerText = "Top5"
        circleView.animate(xAxisDuration: 2, easingOption: .easeOutExpo)
        let dataSet = PieChartDataSet(entries: entrys)
        dataSet.colors = [colors.deepBlue, colors.lightGreen, colors.yellow, colors.lightOrange, colors.lightRed]
        dataSet.valueTextColor = .white
        dataSet.entryLabelColor = .white
        circleView.data = PieChartData(dataSet: dataSet)
        circleView.legend.enabled = false
        view.addSubview(circleView)
    }
    
    @objc func switchAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            pattern = "cases"
        case 1:
            pattern = "pcr"
        case 2:
            pattern = "deaths"
        default:
            break
        }
        loadView()
        viewDidLoad()
    }
    
    @objc func buckButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goCircle() {
        print("tappedNextButton")
    }
    
    func bottomLabel(_ parentView: UIView, _ label: UILabel, _ x: CGFloat, _ y: CGFloat, text: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: size, weight: weight)
        label.frame = CGRect(x: 0, y: y, width: parentView.frame.size.width / 3.5, height: 50)
        label.center.x = view.center.x * x - 10
        parentView.addSubview(label)
    }
}

extension CircleChartViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let index = array.firstIndex(where: { $0.name_ja == searchBar.text }) {
            prefecture.text = "\(array[index].name_ja)"
            pcrCount.text = "\(array[index].pcr)"
            casesCount.text = "\(array[index].cases)"
            deathsCount.text = "\(array[index].deaths)"
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = ""
    }
}



