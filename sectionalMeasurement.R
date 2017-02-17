#sectional measurement
#IRTの購買確率
div<-1000 #積分する区間の分割数
sig<-4 #thetaはプラスマイナス何標準偏差までか
d<-0.8 #dパラ
b<-2 #bパラ
e<-4 #イプシロン
divw<-20　#値引き率の刻み数

x<-(2*sig)/div　#区分の幅
p<-matrix(nrow=div,ncol=3)　#確率計算用の箱
dan<-matrix(nrow=divw,ncol=2)　#p*wの散布図用の箱

for(w in 1:divw){
        w2<-w/divw　#値引き率
        dan[w,1]<-w
        for(i in 1:div){
                theta<-(-sig+i*x)
                p[i,1]<-exp(-(theta^2)/2)/sqrt(2*pi) #thetaごとの標準正規分布の確率密度
                p[i,2]<-d/(1+exp(-1.7*(theta-b+e*w2)))　#thetaごとのIRTのP
                p[i,3]<-(p[i,1]*p[i,2]) #人数の密度とPの積
                dan[w,2]<-sum(p[,3]*x)　#値引き率ごとの購買率
        }
}

plot(dan,type="b")　#目的のグラフ
