//
//  Handy.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 15/04/2021.
//

import UIKit
class PinCodeEntry: UITextField {
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        addTarget(self, action: #selector(fixMe), for: .editingChanged)
    }
    
    @objc private func fixMe() { text = text?.prefix(4) }
}
