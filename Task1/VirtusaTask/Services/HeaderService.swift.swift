import Foundation

public class HeaderService {

 internal func makeAnApiCall(urlString: String, httpMethod: String, httpBody: NSData?, completion: @escaping CompletionHandlerOfApiCall) {

  if let url = URL(string: urlString) {
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    if((HttpTypeOfApi.POST.rawValue == httpMethod) && httpBody != nil) {
        request.httpBody = httpBody
    }
    request.timeoutInterval = TIMEOUT_SECONDS
    request.addValue(HTTPHeaderValueOfApi.APPLICATIONJSON.rawValue, forHTTPHeaderField: HTTPHeaderFieldOfApi.CONTENTTYPE.rawValue)
    request.addValue(HTTPHeaderValueOfApi.APPLICATIONJSON.rawValue, forHTTPHeaderField: HTTPHeaderFieldOfApi.ACCEPT.rawValue)

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
    
        completion(data, response, error)
    
    })

    task.resume()
    } else {
       completion(nil, nil, nil) 
    }
 }    

    

}