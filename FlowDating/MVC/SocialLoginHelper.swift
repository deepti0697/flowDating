
import UIKit
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices
class SocialLoginHelper: UIViewController,GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            let userId = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let googleDetails = ["email" : email ?? "",
                                 "fullname" : fullName ?? "",
                                 "first_name" : givenName ?? "",
                                 "last_name" : familyName ?? "",
                                 "id" :  userId ?? "",
                                 "type" : "google"] as [String:Any]

            print("\(userId ?? "")   \(fullName ?? "")  \(givenName ?? "")  \(familyName ?? "") \(email ?? "")")
//            completion(idToken,googleDetails)
            
            if let comp = self.completionHandler{
                comp(idToken ?? "", googleDetails)
            }
        }
    }
    
    
    static let shared = SocialLoginHelper()
    var fbAccessToken:String!
    var completionHandler : ((_ token:String, _ userInfo: [String : Any]) -> Void)?
    
    func handleLogInWithFacebookButtonPress() {
        
        let fblogin = LoginManager()
        fblogin.logOut()
        
        let loginManager = LoginManager()
        
        func getFacebookProfileInfo(accessToken:String) {
            let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
            
            GraphRequest(graphPath: "me", parameters: params).start(completionHandler: { (connection, result, error) in
                if (error == nil){
                    self.fbAccessToken = accessToken
                    let fbDetails = result as! [String :Any]
                    let facebookDetails = [
                        "email" : fbDetails["email"] as? String ?? "",
                        "fullname" : fbDetails["name"] as? String ?? "",
                        "first_name" : fbDetails["first_name"] as? String ?? "",
                        "last_name" : fbDetails["last_name"] as? String ?? "",
                        "id" :  fbDetails["id"] as? String ?? "",
                        "type" : "fb"] as [String:Any]
                    
                    if let comp = self.completionHandler{
                        comp(accessToken, facebookDetails)
                    }
                }
                else{
                    print(error)
                }
            })
            
        }
        
        if let accessToken = AccessToken.current{
            getFacebookProfileInfo(accessToken: accessToken.tokenString)
        } else {
            
            loginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
                if (error == nil){
                    let fbloginresult : LoginManagerLoginResult = result!
                    if(fbloginresult.grantedPermissions.contains("email")){
                        getFacebookProfileInfo(accessToken: AccessToken.current?.tokenString ?? "")
                    }
                }
            }
        }
    }
    
        func handleLogInWithGoogleButtonPress() {
            GIDSignIn.sharedInstance()?.clientID = "542877390026-35qkmgl7dav6oj65452hpm3urbvj7mc9.apps.googleusercontent.com"
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance()?.delegate = self
            GIDSignIn.sharedInstance()?.signIn()
        }
}

//extension SocialLoginHelper : GIDSignInDelegate{
    // MARK: Google sign data fetched here
  
//}

extension SocialLoginHelper : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    // MARK:- delegate for Apple sign in
    func handleLogInWithAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //Handle error here
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email
            let appleDetails = [
                "email" : userEmail ?? "",
                "fullname" : "\(userFirstName ?? "") " + "\(userLastName ?? "")",
                "first_name" : userFirstName ?? "",
                "last_name" : userLastName ?? "",
                "id" :  userIdentifier,
                "type" : "apple"] as [String:Any]
            
            if let comp = self.completionHandler{
                comp(userIdentifier, appleDetails)
            }
            //Navigate to other view controller
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username,password)
            //Navigate to other view controller
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
