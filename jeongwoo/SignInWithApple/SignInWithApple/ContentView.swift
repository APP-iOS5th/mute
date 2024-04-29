import SwiftUI
import AuthenticationServices


struct ContentView: View {
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    
    var body: some View {
        ZStack {
            Color.white
            if userName.isEmpty {
                SignInWithAppleButton(.signIn, onRequest: onRequest, onCompletion: onCompletion)
                    .signInWithAppleButtonStyle(.black)
                    .frame(width: 200, height: 50)
            } else {
                Text("Welcome\n\(userName), \(userEmail)")
                    .foregroundStyle(.black)
                    .font(.headline)
            }
        }
    }
    
    private func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    private func onCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResult):
            guard let credential = authResult.credential as? ASAuthorizationAppleIDCredential
            else { return }
            
        case .failure(let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
}

#Preview {
    ContentView()
}
