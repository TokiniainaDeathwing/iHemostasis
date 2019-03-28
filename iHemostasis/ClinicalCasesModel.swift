//
//  ClinicalCasesModel.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 28/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import Foundation

class ClinicalCasesModel {
    var title: String?
    var responses: [ClinicalCasesResponseModel] = []
    var statement: String?
    var quizzDetail: NSArray?
    var description: String?
    var explanation: String?
}