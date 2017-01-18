//
//  CustomHomeViewSegue.swift
//  iHungry
//
//  Created by Michael Douglas on 18/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import UIKit

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class CustomHomeViewSegue: UIStoryboardSegue {
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func perform() {
        scale()
    }
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    func scale () {
        let actualViewController = self.source.view
        let destinationViewController = self.destination.view
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        destinationViewController?.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight )
        
        if let window = UIApplication.shared.keyWindow {
            window.insertSubview(destinationViewController!, aboveSubview: actualViewController!)
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                actualViewController?.frame = ((actualViewController?.frame)?.offsetBy(dx: -screenWidth, dy: 0))!
                destinationViewController?.frame = (destinationViewController?.frame.offsetBy(dx: -screenWidth, dy: 0))!
            }) {(Finished) -> Void in
                self.source.navigationController?.pushViewController(self.destination, animated: false)
            }
        }
    }
}
