import Foundation

public class CheckOutService {

 internal func getPeopleListApiCall(data: NSData?, response: NSURLResponse?, error: NSError?, completion: @escaping (_ statusCode: Int, _ peopleItemList: [PeopleItem]?) -> Void) {
     if let receivedResponse = response, let statusCode = receivedResponse.statusCode, statusCode == SUCCESS_STATUSCODE, let receivedData = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let peopleItemList = try jsonDecoder.decode([PeopleItem].self, from: receivedData)
                    completion(statusCode, peopleItemList)
                } catch {
                    completion(FAILURE_GENERIC_STATUSCODE, nil)
                }
            } else {
                completion(FAILURE_GENERIC_STATUSCODE, nil)
            }
 }

 internal func getBoardroomListApiCall(data: NSData?, response: NSURLResponse?, error: NSError?, completion: @escaping (_ statusCode: Int, _ boardroomItemList: [BoardroomItem]?) -> Void) {
     if let receivedResponse = response, let statusCode = receivedResponse.statusCode, statusCode == SUCCESS_STATUSCODE, let receivedData = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let boardroomItemList = try jsonDecoder.decode([BoardroomItem].self, from: receivedData)
                    completion(statusCode, boardroomItemList)
                } catch {
                    completion(FAILURE_GENERIC_STATUSCODE, nil)
                }
            } else {
                completion(FAILURE_GENERIC_STATUSCODE, nil)
            }
 }


}