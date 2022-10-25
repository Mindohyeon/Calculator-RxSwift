//
//  ViewController.swift
//  Calculator-RxSwift
//
//  Created by 민도현 on 2022/10/14.
//

import UIKit
import SnapKit
import Then
import RxSwift

class CalculateVC: UIViewController {
    
    var viewModel: CalculateVM?
    var disposeBag = DisposeBag()
    var result = 0.0
    
    private let inputLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.text = "Input"
    }
    
    private let inputTextField = UITextField().then {

        $0.placeholder = "input"
    }
    
    private let resultLabel = UILabel()
    
    private let sendButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("확인", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        
        inputTextField
            .rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] value in
                print("text = \(value)")
                self?.result = Double(value) ?? 0.0
                self?.resultLabel.text = String((self?.result ?? 0.0) * 1442.45)
            })
            .disposed(by: disposeBag)
        DispatchQueue.main.async {
            print("hihi")
            self.resultLabel.text = String(self.result)
        }
    }
        
    init(viewModel: CalculateVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        view.backgroundColor = .white
        view.addSubviews(inputLabel, inputTextField, resultLabel, sendButton)
    }
    
    private func setLayout() {
        inputLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.centerX.equalToSuperview()
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
    }
}

