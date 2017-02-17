#analysis
library(rstan)
 
scr<-"irt_1pl_0206w6.stan"
#scr<-"irt_1pl_w2.stan"
#scr<-"irt_1pl_w.stan"
head(zozo_new2[,2:21])
head(zozo_new2[,22:41])
 
data<-list(y=as.matrix(zozo_new2[,2:21]),nj=20,ni=ni,w=as.matrix(zozo_new2[,22:41]))
par<-c("theta","b","e","d")
war<-500
ite<-1000
see<-1234
dig<-2
cha<-1
 
fit<-stan(file=scr,model_name=scr,data=data,pars=par,seed=see,chains=cha,warmup=war,iter=ite)
print(fit,pars=par,digits_summary=dig)
 
 
#options(max.print = 1000000)
 
##各パラメータの抽出####
n = ite - war
 
res30 <- matrix(nrow=20,ncol =3)
colnames(res30) <- c("b","e","d")
rownames(res30) <- c("c2","c3","c4","c5","c7","c8","c9","c11","c12","c13","c14","c15","c16","c17","c18","c19","c21","c22","c23","c25")
 
##b
for(l in 1:20){
    start <- 1+(l-1)*n*cha
    end <- n*l*cha
    res30[l,1] <- (mean(rstan::extract(fit)$b[start:end]))
}
 
##e
for(l in 1:20){
  start <- 1+(l-1)*n*cha
  end <- n*l*cha
  res30[l,2] <- (mean(rstan::extract(fit)$e[start:end]))
}
 
##d
for(l in 1:20){
  start <- 1+(l-1)*n*cha
  end <- n*l*cha
  res30[l,3] <- (mean(rstan::extract(fit)$d[start:end]))
}
 
##thetaの切り出し
res32 <- matrix(nrow=nrow(zozo_new2),ncol =1)
tmp <- rstan::extract(fit)$theta
mean(tmp[2,])
tmp[,l]
for(l in 1:nrow(zozo_new2)){
#  start <- 1+(l-1)*n*cha
#  end <- n*l*cha
  res32[l,1] <- (mean(tmp[,l]))
}
 
 
zozo_new2$theta <- res32
 
#csv吐き出し
write.csv(res30,"irtBDE_1-3000.csv")
#csv吐き出し
#write.csv(zozo_new2,"zozo_new2_1-3000.csv")
