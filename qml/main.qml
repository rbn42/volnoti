import QtQuick 2.0
import QtQuick.Controls 1.1

ApplicationWindow {
    id:root
    width:150
    height:root.width*1.06
    x:10
    y:10
    color:'transparent' 
    //flags: Qt.SplashScreen
    //flags: Qt.FramelessWindowHint
    flags: Qt.BypassWindowManagerHint

    Image {
        id:img
        width:root.width
        height:root.width
     //   source: "../res/volume_low.png"
    }

    Image {
        anchors.top:img.bottom
        width:root.width
        height:root.height-root.width
        source: "../res/progressbar_empty.png"
    }

    Item{
        id:vol_full
        anchors.top:img.bottom
    //    width:root.width
        height:root.height-root.width
        clip:true
        Image {
            width:root.width
            height:root.height-root.width
            source: "../res/progressbar_full.png"
        }
    }

    Timer {
        interval: 3000; running: true; 
        onTriggered: Qt.quit()
    }

    Component.onCompleted:{
        var muted=false;
        var vol=-1
        for(var i=1;i<Qt.application.arguments.length-1;i++){
            var s=Qt.application.arguments[i] 
            if(s=='-m')
                muted=true;
            else if(vol<0)
                vol=parseInt(s)
        }
        if(vol<0)vol=0;
        if(vol>100)vol=100;
        vol=vol/100.0
        var ext='.png'
        if(muted)
            img.source="../res/volume_muted"+ext
        else if(vol==0)
            img.source="../res/volume_off"+ext
        else if(vol<1.0/3)
            img.source="../res/volume_low"+ext
        else if(vol<2.0/3)
            img.source="../res/volume_medium"+ext
        else
            img.source="../res/volume_high"+ext

        vol_full.width=root.width*vol
        console.log(muted)
        console.log(vol)
    }
}
