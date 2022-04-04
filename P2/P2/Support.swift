//
//  Support.swift
//  P2
//
//  Created by Zahraa Herz on 03/04/2022.
//

import Foundation

import Foundation
struct Support : Codable {
    let url : String?
    let text : String?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case text = "text"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        text = try values.decodeIfPresent(String.self, forKey: .text)
    }

}
