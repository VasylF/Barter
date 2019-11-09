//
//  FloatLabelTextField.swift
//  
//
//  Created by Vasyl on 11/3/19.
//

import UIKit

class FloatLabelTextField: UITextField {
    private var usernameLabelYAnchorConstraint: NSLayoutConstraint!
    private var usernameLabelLeadingAnchor: NSLayoutConstraint!
    
    private lazy var floatLabel: UILabel! = {
        let label = UILabel()
        label.text = self.placeholder
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.5
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        addConstraint()
    }
    
    fileprivate func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.floatLabel.transform = transform
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func shouldAnimateTo(top: Bool) {
        guard (top && usernameLabelYAnchorConstraint.constant != -18) || !top else { return }
        
        usernameLabelYAnchorConstraint.constant = top ? -18 : 0
        usernameLabelLeadingAnchor.constant = top ? 0 : 8
        let transform = top ? CGAffineTransform(scaleX: 0.8, y: 0.8)
                            : CGAffineTransform(scaleX: 1, y: 1)
        
        performAnimation(transform: transform)
    }
    
    @objc func textFieldBeginEditing(_ textField: FloatLabelTextField) {
        shouldAnimateTo(top: !(textField.text?.isEmpty ?? true))
    }
    
    private func addConstraint() {
        usernameLabelYAnchorConstraint = floatLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        usernameLabelLeadingAnchor = floatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        
        NSLayoutConstraint.activate([
            usernameLabelYAnchorConstraint,
            usernameLabelLeadingAnchor,
        ])
    }
    
    private func configure() {
        addSubview(floatLabel)
        addTarget(self, action: #selector(textFieldBeginEditing(_ :)), for: .allEditingEvents)
        placeholder = ""
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension FloatLabelTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        shouldAnimateTo(top: true)
    }

}
