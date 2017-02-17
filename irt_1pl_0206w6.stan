data{
	int ni;
	int nj;
//	int nrep;
	int<lower=0,upper=1> y[ni,nj];
	real<lower=0,upper=1> w[ni,nj];
}
parameters{
        vector[nj] b;
	vector[ni] theta;
	vector<lower=0>[nj] e;
	vector<lower=0,upper=1.0>[nj] d;
//	real<lower=0> se;
//	real<lower=0> me;
//	real<lower=0,upper=0.5> ww[ni];
//	real<lower=0,upper=1> ww[ni];
//	real<lower=0,upper=1> ww[ni,nj];
}
model{
for (i in 1:ni){
for (j in 1:nj){
	y[i,j]~bernoulli(d[j]/(1+exp(-1.7*(theta[i]-b[j]+e[j]*w[i,j]))));
}
}
		theta~normal(0,1);
//		e~normal(0,2);
//		e~gamma(1,1);
		e~lognormal(1,1);
		b~normal(0,1);
}
