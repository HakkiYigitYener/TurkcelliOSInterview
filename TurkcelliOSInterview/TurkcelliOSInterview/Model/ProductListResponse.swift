import Foundation
struct ProductListResponse : Codable {
	let products : [Product]?

	enum CodingKeys: String, CodingKey {

		case products = "products"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		products = try values.decodeIfPresent([Product].self, forKey: .products)
	}

}
