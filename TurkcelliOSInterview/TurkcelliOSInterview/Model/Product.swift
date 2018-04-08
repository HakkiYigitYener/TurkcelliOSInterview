
import Foundation
struct Product : Codable {
	let productId : String?
	let name : String?
	let price : Int?
	let image : String?
    let description : String?

	enum CodingKeys: String, CodingKey {

		case productId = "product_id"
		case name = "name"
		case price = "price"
		case image = "image"
        case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		productId = try values.decodeIfPresent(String.self, forKey: .productId)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
		image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
