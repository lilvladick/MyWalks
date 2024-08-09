import SwiftUI

struct SaveWalkView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Save this walk?")
                .font(.title)
                .bold()
                .padding(.vertical)
            Text("You can save the path you have taken. In the future, you will be able to view your saved walks.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundStyle(Color.gray)
            HStack {
                Button("No, thanks") {
                    dismiss()
                }
                .padding()
                .frame(width: 120, height: 40)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                
                Button("Save") {
                    //save walk code
                }
                .padding()
                .frame(width: 120, height: 40)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
            .padding(.vertical)
            .foregroundStyle(Color.white).bold()
        }
    }
}

#Preview {
    SaveWalkView()
}
