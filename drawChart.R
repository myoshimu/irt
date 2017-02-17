#Plot estimated parameters
sakuzu <- function(cid,cateid){
  lis <- as.data.frame(c("c3","c7","c8","c11","c12","c13","c14","c18","c19"))
 
  x <- seq(-5,5,length=10000)
# y <- res30[cateid,3]/(1+exp(-1.7*(x-res30[cateid,1]+res30[cateid,2]*zozo_new2[zozo_new2$cid==cid,10+cateid])))
  y <- res30[cateid,3]/(1+exp(-1.7*(x-res30[cateid,1]+res30[cateid,2]*0.5)))
 
  y2<- res30[cateid,3]/(1+exp(-1.7*(x-res30[cateid,1])))
 
  plot(x,y,type="l",main =i,ylab="Pij",xlab="theta",ylim=c(0.0,1.0))
  par(new=T)
  plot(x,y2,type="l",lty=2,ylab="",xlab="",ylim=c(0.0,1.0))
} 
 
##9象限で作図。特徴的な人のcidを突っ込んでプロット
par(mfrow=c(3,3))
cid <- 1203 ##theta最大の人
 
for(i in 1:9){
  sakuzu(cid,cateid=i)
}
