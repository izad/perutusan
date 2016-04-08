//
//  APIResponse.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation
import EVReflection

class APIResponse: EVObject {
    var metadata: Metadata!
    var categories: [Category] = []
    var articles: [Article] = []
    var article: Article?
}