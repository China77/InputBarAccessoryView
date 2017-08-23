//
//  InputBarItem.swift
//  NTInputAccessoryView
//
//  Copyright © 2017 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 8/18/17.
//

import UIKit

open class InputBarItem<T : UIView> {
    
    // MARK: - Properties
    
    open var view: T
    
    fileprivate var onTapAction: ((InputBarItem)->Void)?
    private var onKeyboardEditingBeginsAction: ((InputBarItem)->Void)?
    private var onKeyboardEditingEndsAction: ((InputBarItem)->Void)?
    
    // MARK: - Initialization
    
    public init() {
        view = T()
    }
    
    public init(customView: T) {
        view = customView
    }
    
    // MARK: - Methods
    
    @discardableResult
    open func configure(_ setup: (InputBarItem)->Void) -> Self {
        setup(self)
        return self
    }
    
    @discardableResult
    open func onKeyboardEditingBegins(_ action: @escaping (InputBarItem)->Void) -> Self {
        onKeyboardEditingBeginsAction = action
        return self
    }
    
    @discardableResult
    open func onKeyboardEditingEnds(_ action: @escaping (InputBarItem)->Void) -> Self {
        onKeyboardEditingEndsAction = action
        return self
    }
    
    @objc func didTouchUpInside() {
       onTapAction?(self)
    }
}

public extension InputBarItem where T: UIButton  {
    
    @discardableResult
    public func onTap(_ action: @escaping (InputBarItem)->Void) -> Self {
        onTapAction = action
        view.addTarget(self, action: #selector(InputBarItem.didTouchUpInside), for: .touchUpInside)
        return self
    }
}