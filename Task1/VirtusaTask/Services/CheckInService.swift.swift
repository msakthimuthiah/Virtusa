import Foundation

enum HttpTypeOfApi: String {
      case POST = "POST"
      case GET  = "GET"
}

enum TypeOfApiCall: Int {
      case GETPEOPLELIST = 1
      case GETBOARDROOMLIST = 2
}

enum HTTPHeaderFieldOfApi: String {
      case CONTENTTYPE = "Content-Type"
      case ACCEPT  = "Accept"
}

enum HTTPHeaderValueOfApi: String {
      case APPLICATIONJSON = "application/json"
}

public class CheckInService {

 internal func isInternetConnected() -> Bool {
	let isInternetConnected = Reachability.isConnectedToNetwork() ? true : false
	return isInternetConnected 
 }

 internal func getPeopleListApiCall(completion: @escaping (_ statusCode: Int, _ peopleItemList: [PeopleItem]?) -> Void) {
     let urlOfPeopleListApiCall = PRE_URL_ENDPOINT + PEOPLE_LIST_URL_ENDPOINT
     let httpMethod = HttpTypeOfApi.GET.rawValue
     HeaderService().makeAnApiCall(urlString: urlOfPeopleListApiCall, httpMethod: httpMethod, httpBody: nil) { (data, response, error) in
            CheckOutService().getPeopleListApiCall(data: data, response: response, error: error) { (statusCode, peopleItemList) in 
                completion(statusCode, peopleItemList)
            }
     }
 }   

 internal func getBoardroomListApiCall(completion: @escaping (_ statusCode: Int, _ boardroomItemList: [BoardroomItem]?) -> Void) {
     let urlOfBoardroomListApiCall = PRE_URL_ENDPOINT + BOARDROOM_LIST_URL_ENDPOINT
     let httpMethod = HttpTypeOfApi.GET.rawValue
     HeaderService().makeAnApiCall(urlString: urlOfBoardroomListApiCall, httpMethod: httpMethod, httpBody: nil) { (data, response, error) in
            CheckOutService().getBoardroomListApiCall(data: data, response: response, error: error) { (statusCode, boardroomItemList) in 
                completion(statusCode, boardroomItemList)
            }
     }
 }    


}




