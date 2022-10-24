import Foundation

#if TEST_APP_ENVIRONMENT
let BASE_URL = "https://61e947967bc0550017bc61bf.mockapi.io/api/"
#elseif LIVE_APP_ENVIRONMENT
let BASE_URL = "https://61e947967bc0550017bc61bf.liveapi.io/api/"
#else
let BASE_URL = "https://61e947967bc0550017bc61bf.mockapi.io/api/"
#endif

let VERSION_URL_ENDPOINT = "v1/"
let PRE_URL_ENDPOINT = BASE_URL + VERSION_URL_ENDPOINT
let PEOPLE_LIST_URL_ENDPOINT = "people"
let BOARDROOM_LIST_URL_ENDPOINT = "rooms"

let TIMEOUT_SECONDS = 30
let SUCCESS_STATUSCODE = 200
let FAILURE_GENERIC_STATUSCODE = 0

typealias CompletionHandlerOfApiCall = (let data: NSData?, let response: NSURLResponse?, let error: NSError?)
