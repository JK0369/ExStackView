//
//  ViewController.swift
//  ExStackView
//
//  Created by 김종권 on 2023/05/06.
//

import UIKit

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        view.addSubview(stackView)
        stackView.addArrangedSubview(MyView())
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // Occured memory leak!!
//    @objc private func tap() {
//        stackView.arrangedSubviews
//            .forEach(stackView.removeArrangedSubview(_:))
//    }
    
    @objc private func tap() {
        let subviews = stackView.arrangedSubviews
        stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview(_:))
        subviews.forEach { $0.removeFromSuperview() }
    }
}

class MyView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .yellow
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 200),
            widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        print("DEINIT: MyView")
    }
}
