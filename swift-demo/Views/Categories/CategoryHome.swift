import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData;
    @State private var showingProfile = false;
    
    var body: some View {
        NavigationView {
            List {
                modelData.features[2]
                    .image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets()); // set the edge inset to 0 so the component can fill the whole parent container
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) {
                    key in
                    CategoryRow (categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets()); // fill the cornor
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData);
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
