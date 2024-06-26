//
//  HomeView.swift
//  KosKita
//
//  Created by Heical Chandra on 31/03/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @EnvironmentObject var deckViewModel: DeckViewModel    
    var body: some View {
        ScrollView{
            PersonalDeck()

        }.navigationBarBackButtonHidden(true).padding()
    }
}

#Preview {
    NavigationView{
        HomeView()
    }.environmentObject(RecipeViewModel()).environmentObject(DeckViewModel())
}

struct PersonalDeck: View {
    let gridItems = Array(repeating: GridItem(), count: 2) // 2 kolom
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @EnvironmentObject var deckViewModel: DeckViewModel
    @State var textFieldText: String = ""
    
    @State var item1: Int = 0
    @State var priceItem1: Int = 0
    @State var item2: Int = 0
    @State var priceItem2: Int = 0
    @State var item3: Int = 0
    @State var priceItem3: Int = 0
    
    @State var priceAmount: Int = 0
    
    @State var notEnough: Bool = false
    @State var isDeck: Bool = false
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        Group {
            VStack {
//                if let enteredPrice = Int(textFieldText), priceAmount > enteredPrice {
//                    notEnough = true
//                }
                VStack{
                    HStack {
                        Text("").frame(height: 60).leftBorder(width: 20, color: priceAmount > (Int(textFieldText) ?? 0) ? .red : .blueAsset)
                        VStack {
                            HStack{
                                Text("Your Budget is").font(.system(size: 20)).padding(.leading, 5)
                                Spacer()
//                                Text(String(priceAmount))
//                                Text(String(item1))
                            }
                            HStack {
                                Text("Rp.")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .padding(.leading, 8)
                                TextField("0", text: $textFieldText)
                                                        .padding(.trailing)
                                                        .frame(height: 50)
                                                        .foregroundColor(.black)
                                                        .keyboardType(.numberPad)
                                                        .font(.system(size: 40))
                                                    .bold()
                            }

                            }.padding()
                        }
                    }

                    VStack {
                        HStack{
                            Text("Add to your deck").fontWeight(.semibold).font(.system(size: 17))
                            Spacer()
                            
                            HStack{
                                Image(systemName: "bookmark")
                                Text("Save")
                            }.padding(6).padding(.horizontal, 8).background(.blueAsset).foregroundColor(.white).cornerRadius(20).onTapGesture {
                                withAnimation(.linear) {
                                    if priceAmount <= 1 {
                                        alertTitle = "Select Food Before Save deck"
                                        showAlert.toggle()
                                    }
                                    if item1 != 0 {
                                        deckViewModel.addDeck(item1: item1, item2: item2, item3: item3)
                                        alertTitle = "Item Saved"
                                        showAlert.toggle()
                                    }
                                }
                            }
                        }
                        HStack{
                            VStack{
                                if item1 == 0 {
                                    Group {
                                        Image(systemName: "plus")
                                            .resizable().frame(width: 25, height: 25)
                                    }.frame(width: 105, height: 125).foregroundColor(.blueAsset).background(.secondary.opacity(0.2)).cornerRadius(20)
                                } else {
                                    ForEach(recipeViewModel.items.filter { $0.id == item1 }) { filteredItem in
                                        ZStack {
                                            VStack {
                                                URLImageView(url: filteredItem.image).frame(width: 105, height: 125)
    //                                            Text(filteredItem.title)
                                            }
                                            VStack{
                                                Spacer()
                                                Group {
                                                    Text(filteredItem.title).foregroundColor(.white).padding(6).lineLimit(2).fontWeight(.semibold).font(.system(size: 15))
                                                }.background(Color.black.opacity(0.5))
                                            }
                                        }.cornerRadius(20).onTapGesture{
                                            item1 = 0
                                            priceAmount = priceAmount - priceItem1
                                            isDeck = false
                                            recipeViewModel.delDeck(item: filteredItem)
                                            priceItem1 = 0
                                    }
                                    }
                                }
                            }
                            VStack{
                                if item2 == 0 {
                                    Group {
                                        Image(systemName: "plus")
                                            .resizable().frame(width: 25, height: 25)
                                    }.frame(width: 105, height: 125).foregroundColor(.blueAsset).background(.secondary.opacity(0.2)).cornerRadius(20)
                                } else {
                                    ForEach(recipeViewModel.items.filter { $0.id == item2 }) { filteredItem in
                                        ZStack {
                                            VStack {
                                                URLImageView(url: filteredItem.image).frame(width: 105, height: 125)
    //                                            Text(filteredItem.title)
                                            }
                                            VStack{
                                                Spacer()
                                                Group {
                                                    Text(filteredItem.title).foregroundColor(.white).padding(6).lineLimit(2).fontWeight(.semibold).font(.system(size: 15))
                                                }.background(Color.black.opacity(0.5))
                                            }
                                        }.cornerRadius(20).onTapGesture{
                                            item2 = 0
                                            priceAmount = priceAmount - priceItem2
                                            isDeck = false
                                            recipeViewModel.delDeck(item: filteredItem)
                                            priceItem2 = 0
                                    }
                                    }
                                }
                            }
                            VStack{
                                if item3 == 0 {
                                    Group {
                                        Image(systemName: "plus")
                                            .resizable().frame(width: 25, height: 25)
                                    }.frame(width: 105, height: 125).foregroundColor(.blueAsset).background(.secondary.opacity(0.2)).cornerRadius(20)
                                } else {
                                    ForEach(recipeViewModel.items.filter { $0.id == item3 }) { filteredItem in
                                        ZStack {
                                            VStack {
                                                URLImageView(url: filteredItem.image).frame(width: 105, height: 125)
    //                                            Text(filteredItem.title)
                                            }
                                            VStack{
                                                Spacer()
                                                Group {
                                                    Text(filteredItem.title).foregroundColor(.white).padding(6).lineLimit(2).fontWeight(.semibold).font(.system(size: 15))
                                                }.background(Color.black.opacity(0.5)).frame(maxWidth:.infinity)
                                            }
                                        }.cornerRadius(20).onTapGesture{
                                            item3 = 0
                                            priceAmount = priceAmount - priceItem3
                                            isDeck = false
                                            recipeViewModel.delDeck(item: filteredItem)
                                            priceItem3 = 0
                                    }
                                    }
                                }
                            }
                        }
                    }.padding().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(.white).cornerRadius(15).padding(.bottom, 5).padding(.horizontal, 5)
            }.background(Blur(style: .systemThinMaterial).background(.secondary.opacity(0.2)))
        }.cornerRadius(20).padding()
            .background(Image("bulat"))
            
            if(textFieldText == ""){
                Text("No data available!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.secondary)
                Text("Input your daily budget first").foregroundColor(.secondary)
                Image("noData").padding()
            }
        if let budget = Int(textFieldText), budget < 5000{
            Text("No data available!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.secondary)
            Text("Input your daily budget first").foregroundColor(.secondary)
            Image("noData").padding()
        }
        if let budget = Int(textFieldText), budget > 5000{
                ZStack {
                    VStack {
                        Image("bgRecomen3")
                        Spacer()
                    }
                    VStack {
                        HStack{
                            Text("Recommended").bold().font(.title3).padding(.top)
                            Spacer()
                        }.padding(.horizontal, 20)
                        LazyVGrid(columns: gridItems, spacing: 20) {
                                if let enteredPrice = Int(textFieldText) {
                                    ForEach(recipeViewModel.items.filter { $0.price <= enteredPrice }) { item in
                                        ZStack {
                                            NavigationLink(destination: DetailView(id: item.id)){
                                                RecipeList(isDeck: isDeck, item: item)
                                            }.foregroundColor(.black)
//                                            RecipeList(isDeck: isDeck, item: item)
                                            VStack{
                                                Spacer()
                                                HStack {
                                                    Spacer()
                                                    Image(item.isDeck ? "plusActive" : "plusInactive")
                                                        .foregroundColor(item.isDeck ? .orangeAsset : .orangeAsset).padding(.bottom, 25).padding(.trailing, 15)
                                                }
                                            }.onTapGesture {
                                                withAnimation(.linear) {
                                                    recipeViewModel.addDeck(item: item)
                                                    if item1 == 0 {
                                                        if maxAmount(){
                                                            item1 = item.id
                                                            priceItem1 = item.price
                                                            priceAmount = priceAmount + priceItem1
                                                            isDeck = true
                                                        }
                                                    } else if item2 == 0 {
                                                        if maxAmount(){
                                                            item2 = item.id
                                                            priceItem2 = item.price
                                                            priceAmount = priceAmount + priceItem2
                                                            isDeck = true
                                                        }
                                                    } else if item3 == 0 {
                                                        if maxAmount(){
                                                            item3 = item.id
                                                            priceItem3 = item.price
                                                            priceAmount = priceAmount +  priceItem3
                                                            isDeck = true
                                                        }

                                                    }
                                                    
                                                }
                                        }
                                        }
                                    }
                                }
                            }
                        .padding(.horizontal, 10)
                    }.background(Blur(style: .systemThinMaterial).background(.secondary.opacity(0.2))).alert(isPresented: $showAlert, content: getAlert).cornerRadius(24).padding(.horizontal).padding(.bottom, 50)
                }
            }

        }
    func maxAmount() -> Bool {
        if let textFieldValue = Int(textFieldText) {
            if priceAmount >= (textFieldValue - 5000) {
                alertTitle = "Maximal Amount reached!"
                showAlert.toggle()
                return false
            }
        }
        return true
    }
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}
    
// Blur View
struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct LeftBorder: ViewModifier {
    var width: CGFloat
    var color: Color

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .frame(width: width, height: nil)
                    .foregroundColor(color)
                    .edgesIgnoringSafeArea(.vertical)
                    .offset(x: 0, y: 0)
            )
    }
}

extension View {
    func leftBorder(width: CGFloat, color: Color) -> some View {
        self.modifier(LeftBorder(width: width, color: color))
    }
}
