//
//  MapView.swift
//  MyMap
//
//  Created by みねた on 2022/02/02.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let searchKey: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(searchKey)
        
        let geocoder = CLGeocoder()
        //CLGreocoderクラスは緯度経度から住所を検索することができる。また、住所から緯度経度を検索できる。
        
        geocoder.geocodeAddressString(
            searchKey,
            //第一引数 [addressString] => 検索したい場所を記述した文字列
            completionHandler: { (placemarks,error) in
            //第二引数 [completionHandler] 結果と一緒に実行するクロージャ(まとまった処理)
                if let unwrapPlacemarks = placemarks,
                   //リクエストの結果が存在し、1件目の情報から位置情報を取り出す
                   //placemarksは取得に成功した位置情報が格納されている
                   let firstPlacemark = unwrapPlacemarks.first ,
                   //[unwrapPlacemarks]にはアンラップされた[placemarks]の情報が格納されている
                   //[unwrapPlacemarks]には複数の位置情報が格納されている配列。
                   //配列の1つ目には最も目的に近い位置情報が格納されている => .firstで1つ目の情報を取り出す。
                   let location = firstPlacemark.location {
                    //[firstPlacemark]には取得した位置情報の最も近い1件目が格納されている。
                    //その定数から緯度経度、高度などの情報が格納されている[location]を取り出す

                    let targetCoordinate = location.coordinate
                    //[location]は緯度経度、高度が格納されているのでcoordinateで緯度経度のみ取り出す。
                    print(targetCoordinate)
                    //緯度経度をデバッグエリアに出力
                    
                    let pin = MKPointAnnotation()
                    //MKPointAnnotationインスタンスを生成。
                    //MKPOintAnnotationはピンを置くための機能が利用できる。
                    
                    pin.coordinate = targetCoordinate
                    
                    pin.title = searchKey
                    uiView.addAnnotation(pin)
                    
                    uiView.region = MKCoordinateRegion(
                    center: targetCoordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0
                    )
                }
            })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "東京タワー")
    }
}
