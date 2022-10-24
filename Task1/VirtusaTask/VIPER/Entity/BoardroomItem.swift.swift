import Foundation

//MARK: BoardroomItem
public struct BoardroomItem: Codable {
   private(set) var id: String ?? ""
   private(set) var createdAt: String ?? ""
   private(set) var isAvailable: Bool ?? false
   private(set) var maxOccupancy: Int64 ?? 0

   enum CodingKeys: String, CodingKey {
       case id = "id"
       case createdAt = "createdAt"
       case isAvailable = "isOccupied"
       case maxOccupancy = "maxOccupancy"
   }

}