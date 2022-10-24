import Foundation

//MARK: PeopleItem
public struct PeopleItem: Codable {
   private(set) var id: String ?? ""
   private(set) var createdAt: String ?? ""
   private(set) var firstName: String ?? ""
   private(set) var lastName: String ?? ""
   private(set) var imageUrl: String ?? ""
   private(set) var email: String ?? ""
   private(set) var jobTitle: String ?? ""
   private(set) var favouriteColor: String ?? ""

   enum CodingKeys: String, CodingKey {
       case id = "id"
       case createdAt = "createdAt"
       case firstName = "firstName"
       case lastName = "lastName"
       case imageUrl = "avatar"
       case email = "email"
       case jobTitle = "jobtitle"
       case favouriteColor = "favouriteColor"
   }

}