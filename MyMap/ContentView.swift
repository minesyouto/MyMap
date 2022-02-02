//
//  ContentView.swift
//  MyMap
//
//  Created by みねた on 2022/02/02.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var inputText: String = ""
    //入力されたテキスト
    @State var dispsearchKey: String = ""
    //入力されたテキストを保存するための変数
    @State var dispMapType: MKMapType = .standard
    //マップの最初の状態はデフォルトから
    var body: some View {
        VStack {
            TextField("キーワード", text:$inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    dispsearchKey = inputText
                    //入力が完了されたとき、inputTextをdispsearchKeyに代入
                }
                .padding()
            ZStack(alignment: .bottomTrailing) {
                //奥から手前方向にレイアウト(右下基準で配置する)
                MapView(searchKey: dispsearchKey, mapType: dispMapType)
                Button(action: {
                    if dispMapType == .standard {
                        dispMapType = .satellite
                    } else if dispMapType == .satellite {
                        dispMapType = .hybrid
                    } else if dispMapType == .hybrid {
                        dispMapType = .satelliteFlyover
                    } else if dispMapType == .satelliteFlyover {
                        dispMapType = .hybridFlyover
                    } else if dispMapType == .hybridFlyover {
                        dispMapType = .mutedStandard
                    } else if dispMapType == .mutedStandard {
                        dispMapType = .standard
                    }
                }) {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0, height: 35.0, alignment: .leading)
                }//Buttonここまで
                .padding(.trailing, 20.0)
                .padding(.bottom, 30.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
