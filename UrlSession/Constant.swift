//
//  Constant.swift
//  UrlSession
//
//  Created by Mangi on 21/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

enum SocialPlatform {
    case facebook
    case twitter
    case linkedIn
    case instagram
}

//MARK:- Raw values
enum EnumWithRawValues: String {
    case facebook = "Facebbok"
    case twitter = "Twitter"
    case instagram = "Instagram"
    case linkedIn = "LinkedIn"
}


//MARK:- Iterable values
enum EnumWithIterableValues: String, CaseIterable {
    case facebook = "Facebbok"
    case twitter = "Twitter"
    case instagram = "Instagram"
    case linkedIn = "LinkedIn"
}

//MARK:- Associated Values
enum EnumWithAssociatedValues {
    case twitter(followers: Int)
    case youtube(subscriber: Int)
    case facebook
    case instagram
}

//MARK:- Login errors
enum LoginErrors: Error {
    case incompleteForm
    case invalidEmail
    case incorrectPasswordLength
}
