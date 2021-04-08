// Necessary variables to make a requests
let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
let urlBase = "https://desafio-mobile-bff.herokuapp.com"
let myBalance = "/myBalance"
let myStatement = "/myStatement/"
let detail = "/myStatement/detail/"

// Colors of application
let gray = "#828282"
let black = "#202021"
let lightGray = "#f8f8f8"
let lightGreen = "#00c1af"

// function to concatenate the limite of data to get in a request and the offset to say what the page do you want.
func setStatementDataRequest(limit: String, offset: String) -> String {
    return myStatement + limit + "/" + offset
}
