//
//  CustomButton.swift
//  MonsterWars
//
//  Created by Christian Lysne on 13/01/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class FocusButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 10
    }
}

#if os(tvOS)
extension FocusButton {
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        if (context.nextFocusedView == self){
            
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformScale(self.transform, 1.1, 1.1)
                
                },
                completion: nil
            )
        } else if(context.previouslyFocusedView == self) {
            
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformIdentity
                },
                completion: nil
            )
        }
    }
}
#endif