//
//  TeacheModel.swift
//  Tutor Panel
//
//  Created by MetaDots on 23/09/2025.
//

struct TeacherCard: Identifiable, Codable {
    let id: String
    let name: String
    let location: String
    let experience: String
    let degree: String
    let phone: String
    let specialization: String
    let language: [String]
    let picture: String?
    
    var fullImageURL: String {
        if let picture = picture, !picture.isEmpty {
            return "http://localhost:8020/" + picture
        } else {
            return "" // fallback if no image
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, experience, degree, phone, specialization, language, picture
    }
    
    // ✅ Custom init for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        experience = try container.decodeIfPresent(String.self, forKey: .experience) ?? ""
        degree = try container.decodeIfPresent(String.self, forKey: .degree) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        specialization = try container.decodeIfPresent(String.self, forKey: .specialization) ?? ""
        picture = try container.decodeIfPresent(String.self, forKey: .picture)
        
        // ✅ Language string ya array dono handle karo
        if let langs = try? container.decode([String].self, forKey: .language) {
            language = langs
        } else if let singleLang = try? container.decode(String.self, forKey: .language) {
            language = singleLang.isEmpty ? [] : [singleLang]
        } else {
            language = []
        }
    }
    
    // ✅ Encode method bhi likhna zaroori hai kyunki custom init(from:) likha hai
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(experience, forKey: .experience)
        try container.encode(degree, forKey: .degree)
        try container.encode(phone, forKey: .phone)
        try container.encode(specialization, forKey: .specialization)
        try container.encode(picture, forKey: .picture)
        try container.encode(language, forKey: .language)
    }
}
